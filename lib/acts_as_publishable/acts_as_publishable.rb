module ActsAsPublishable
  def self.included(base)
    base.extend ActsAsPublishable::ClassMethods
  end
  
  module ClassMethods
    def acts_as_publishable(options = {})
      metaclass = (class << self; self; end)
      
      return if metaclass.included_modules.include?(ActsAsPublishable::InstanceMethods)
      
      cattr_accessor :publish_now_column, :published_from_column, :published_to_column, :default_published_now
      
      self.publish_now_column = options[:publish_now_column] || 'publish_now'
      self.published_from_column = options[:published_from_column] || 'published_from'
      self.published_to_column = options[:published_to_column] || 'published_to'
      self.default_published_now = (options[:default_published_now] == true)
      
      named_scope :published, :conditions => ["#{publish_now_column} = :published OR (#{published_from_column} <= :published_from AND #{published_to_column} >= :published_to)", {:published => true, :published_from => Time.now, :published_to => Time.now}]
      
      before_save { |publishable| publishable[publish_now_column.to_sym] = default_published_now if publishable[publish_now_column.to_sym].nil?; true }
      send :include, ActsAsPublishable::InstanceMethods
    end
    
    
  end
  
  module SingletonMethods
    def find_published(options = {})
      scope = scoped(:conditions => ["#{publish_now_column} = :published OR (#{published_from_column} <= :published_from AND #{published_to_column} >= :published_to)", {:published => true, :published_from => Time.now, :published_to => Time.now}])
      scope.find(:all, options)
    end
  end
  
  module InstanceMethods
    def published?
      now = Time.now
      @from ||= self[self.class.published_from_column.to_sym]
      @to ||= self[self.class.published_to_column.to_sym]
      self[self.class.publish_now_column.to_sym] || ((@from && @from <= now) && (@to && @to >= now))
    end
  end
end