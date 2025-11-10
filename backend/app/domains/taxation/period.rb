module Taxation
  class Period
    attr_reader :from, :to, :granularity # :quarter or :month

    def self.quarter(year:, q:)
      raise ArgumentError, "q must be 1..4" unless (1..4).cover?(q.to_i)
      
      month = (q.to_i - 1) * 3 + 1
      first = Date.new(year.to_i, month, 1)
      last  = (first >> 3) - 1 # 3 months ahead, minus 1 day
      
      new(first, last, :quarter)
    end

    def self.month(year:, m:)
      raise ArgumentError, "m must be 1..12" unless (1..12).cover?(m.to_i)
      
      first = Date.new(year.to_i, m.to_i, 1)
      last  = (first >> 1) - 1

      new(first, last, :month)
    end

    def initialize(from, to, granularity)
      @from, @to, @granularity = from, to, granularity
    end

    def to_h
      { from: from, to: to, granularity: granularity }
    end
  end
end
