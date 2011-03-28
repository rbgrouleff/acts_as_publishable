module ActsAsPublishable
  extend ActiveSupport::Concern

  module ClassMethods
    def acts_as_publishable(options = {})
      metaclass = (class << self; self; end)
      
      return if metaclass.included_modules.include?(ActsAsPublishable::InstanceMethods)
      
      cattr_accessor :publish_now_column, :published_from_column, :published_to_column, :default_published_now
      
      self.publish_now_column = options[:publish_now_column] || 'publish_now'
      self.published_from_column = options[:published_from_column] || 'published_from'
      self.published_to_column = options[:published_to_column] || 'published_to'
      self.default_published_now = (options[:default_published_now] == true)
      
      scope :published, where(["#{publish_now_column} = :published OR (#{published_from_column} <= :published_from AND #{published_to_column} >= :published_to)", {:published => true, :published_from => Time.now.utc, :published_to => Time.now.utc}])
      
      before_save { |publishable| publishable[publish_now_column.to_sym] = default_published_now if publishable[publish_now_column.to_sym].nil?; true }
      
      validate_chronology
      
      send :include, ActsAsPublishable::InstanceMethods
    end
    
    def validate_chronology
      validates_each published_to_column do |publishable, attribute, value|
        unless value.blank? || publishable[published_from_column.to_sym].blank?
          publishable.errors.add(attribute, :earlier_than_published_from, :message => "cannot be set earlier than #{published_from_column.to_s.humanize}") unless publishable[published_from_column.to_sym] < value
        end
      end
    end
  end
  
  module InstanceMethods
    def published?
      now = Time.now
      @from ||= self[self.class.published_from_column.to_sym]
      @to ||= self[self.class.published_to_column.to_sym]
      is_published_now = self[self.class.publish_now_column.to_sym]
      is_published_from_in_the_past = @from && @from <= now
      is_published_to_in_the_future = @to && @to >= now
      is_published_now || is_published_from_in_the_past && !@to || !@from && is_published_to_in_the_future || is_published_from_in_the_past && is_published_to_in_the_future
    end
  end
end
