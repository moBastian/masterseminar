# -*- encoding : utf-8 -*-
class Result < ActiveRecord::Base

  belongs_to :student
  belongs_to :measurement

  serialize :items, Array         #Speichert die IDs der content_items die für diese Messung verwendet werden
  serialize :responses, Array     #Speichert die 1/0 Ergebnisse zu den Items aus items
  serialize :extra_data, Hash     #Speichert zusätzlicher Infos als Key/Value Paare. Feste Keys:
                                  #-times: Reaktionszeiten
                                  #-answers: Die von den Kindern gegebenen Antworten
                                  #-intro: Intro Items für den Test
                                  #-outro: Outro Items für den Test

  #Calculate new running total of the fraction of correct items. Must be called everytime the responses change.
  #Not used from outside
  def update_total
    if count_NA == responses.size
      self.total = 0
    else
      self.total = responses.map{|x| x == nil ? 0:x}.sum.to_f/(responses - [nil]).size
    end
    save
  end

  #Create an empty set of results, but already draw the items that will be used.
  #Used to initialize a result when first starting a measurement.
  def initialize_results()
    self.responses = Array.new
    self.extra_data = Hash.new
    drawn_items = measurement.assessment.test.draw_items(self.getPriorResultsItem(measurement, self.student))
    self.extra_data["intro"] = drawn_items[0]
    self.items = drawn_items[1]
    self.extra_data["outro"] = drawn_items[2]
    self.responses[self.items.size-1] = nil
    update_total
  end

  #Parses a String or additional data in the form "a,b,c" where each entry denotes the data for an item. The data is stored under the labels given in "labels" also in the form "x,y,z".
  def parse_data(labels, data)
    labels.length.times do |i|
      vals = (data[i] + ",").split(/(,)/).delete_if{ |e| e == ","}   #Keep empty parts as well, especially also if the last entry is empty.
      if (labels[i] == "times")
        self.extra_data["times"] = vals.map{|x| x.to_i}
      else
        self.extra_data[labels[i]] = vals
      end
    end
    save
  end

  #Parses a string of results in the form "1,0,1,1,..." where each 0/1 denotes the result of an item.
  #Used to crate an update results
  def parse_csv(data)
    if data.nil?
      self.responses[self.items.size-1] = nil
      return
    else
      vals = data.split(',')
      vals.length.times do |i|
          self.responses[i] =  vals[i] == "1" ? 1 : (vals[i] == "0" ? 0 : nil)
      end
    end
    update_total
  end

  #Sets the result from a hash of (k, v) pairs where k denotes an item_id and v the 0/1 result for this item.
  #Used to update results
  def parse_Hash(hash)
    hash.each do |i, r|
      p = items.index(i.to_i)
      responses[p] = (r == "1" ? 1 : (r == "0" ? 0 : nil)) unless p.nil?
    end
    update_total
  end

  #Create a string in the form of "0,1,0,1,..." that denotes the result for each item in the respective order. If includeNA is false, every NA response will be transformed to 0 in the result.
  #Used for exporting the results.
  def to_csv(includeNA)
    responses.map{|x| (x == nil && includeNA)  ? 'NA': (x == nil ? 0 : x.to_s) }.join(",")
  end

  #Create an array representation of the results.
  #If extra_data contain "times" then export the times instead of the 1/0 values.
  #Used for exporting to XLS
  def to_a(itemset)
    res = []
    itemset.each do |i|
      val = responses[items.index(i)]
      if extra_data.has_key?('times')
        time = extra_data['times'][items.index(i)].nil? ? nil : extra_data['times'][items.index(i)].to_i
        res = res + [time.nil? ? '' : (val == 1 ? time : -1*time)]
      else
        res = res + [val.nil? ? '' :val]
      end
    end
    return res
  end

  #Calculate the number of correct items.
  #Used for displaying the results
  def score
    if responses.include?(1) | responses.include?(0)
      return responses.map{|x| x == nil ? 0:x}.sum
    else
      return nil
    end
  end

  #Calculate ethe number of all items with a "1" response
  #Used for displaying the results
  def count_1
    return (responses - [nil, 0]).size
  end

  #Calculate ethe number of all items with a "0" response
  #Used for displaying the results
  def count_0
    return (responses - [nil, 1]).size
  end

  #Calculate ethe number of all items with a "NA" response
  #Used for displaying the results
  def count_NA
    return (responses - [0, 1]).size
  end

  #Get the results of the most recent prior measurement of the same assessment.
  #Used for generating student feedback after a measurement.
  def getPriorResult()
    measurements = Measurement.where("assessment_id = ? AND created_at < ?", measurement.assessment, measurement.created_at)
    res = Result.where(:measurement => measurements, :student => student).order(created_at: :desc).first
    if res.nil?
      return -1
    else
      t = res.score
      return t.nil? ? 0 : t
    end
  end

  def getPriorResultsItem(measurement, student)
    measurements = Measurement.where("assessment_id = ? AND created_at < ?", measurement.assessment, measurement.created_at)
    res = Result.where(:measurement => measurements, :student => student)
    items =[]
    for r in res
      count = 0
      for respond in r.responses
        if(!respond.nil?)
          items = items + Item.where(id:r.items[count])
        end
        count= count +1
      end
    end
    return items.uniq
  end


end
