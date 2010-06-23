$LOAD_PATH << File.dirname(__FILE__)

require 'spec_helper'

describe "Publishable with default columns" do
  
  before :all do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :posts do |t|
        t.boolean :publish_now
        t.datetime :published_from
        t.datetime :published_to
      end
    end

    class Post < ActiveRecord::Base
      acts_as_publishable
    end
  end
  
  after :all do
    ActiveRecord::Schema.define(:version => 1) do
      drop_table :posts
    end
  end
  
  before :each do
    @post = Post.new
  end
  
  it "has a named scope" do
    Post.should respond_to(:published)
  end
  
  it "has a class attribute for the publish_now column" do
    Post.publish_now_column.should == 'publish_now'
  end
  
  it "has a class attribute for the published_from column" do
    Post.published_from_column.should == 'published_from'
  end
  
  it "has a class attribute for the published_to column" do
    Post.published_to_column.should == 'published_to'
  end
  
  it "has a published? instance method" do
    @post.published?.should be_false
  end
  
  it "has an instance attribute called publish_now" do
    @post.publish_now.should be_false
  end
  
  it "has an instance attribute called published_from" do
    @post.should respond_to(:published_from)
  end
  
  it "has an instance attribute called published_to" do
    @post.should respond_to(:published_to)
  end
  
  it "has an instance attribute called publish_now" do
    @post.should respond_to(:publish_now)
  end
  
  it "should persist publish_now to the database" do
    @post.publish_now = true
    @post.save
    Post.find(@post.id).publish_now.should be_true
  end
  
  it "should persist published_to and published_from dates" do
    tomorrow = Time.parse 'Sun Jun 20 17:03:03 +0200 2010'
    a_day_ago = Time.parse 'Fri Jun 18 17:03:03 +0200 2010'
    @post.published_from = a_day_ago
    @post.published_to = tomorrow
    @post.save_without_validation
    Post.find(@post.id).published_from.should eql(a_day_ago)
    Post.find(@post.id).published_to.should eql(tomorrow)
   end
  
  it "is published if publish_now is true" do
    @post.publish_now = true
    @post.save
    @post.published?.should be_true
  end
  
  it "should be invalid if published_to is set in the past" do
    @post.published_to = 1.day.ago
    @post.published_from = Time.now
    @post.valid?.should_not be_true
  end
end

describe "Publishable with default_published_now set to true" do
  before :all do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :posts do |t|
        t.boolean :publish_now
        t.datetime :published_from
        t.datetime :published_to
      end
    end
    
    class Post < ActiveRecord::Base
      acts_as_publishable :default_published_now => true
    end
  end
  
  after :all do
    ActiveRecord::Schema.define(:version => 1) do
      drop_table :posts
    end
  end
  
  before :each do
    @post = Post.new
  end
  
  it "should be published by default" do
    @post.save
    @post.publish_now.should be_true
    
  end
end

describe "Publishable with non-default column names" do
  before :all do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :publishables do |t|
        t.boolean :now
        t.datetime :from
        t.datetime :to
      end
    end
    
    class Publishable < ActiveRecord::Base
      acts_as_publishable :publish_now_column => :now, :published_from_column => :from, :published_to_column => :to
    end
  end
  
  after :all do
    ActiveRecord::Schema.define(:version => 1) do
      drop_table :publishables
    end
  end
  
  before :each do
    @publishable = Publishable.new
  end
  
  it "should have a now column" do
    @publishable.should respond_to(:now)
  end
  
  it "should persist to and from dates" do
    tomorrow = Time.parse 'Sun Jun 20 17:03:03 +0200 2010'
    a_day_ago = Time.parse 'Fri Jun 18 17:03:03 +0200 2010'
    @publishable.from = a_day_ago
    @publishable.to = tomorrow
    @publishable.save
    Publishable.find(@publishable.id).from.should eql(a_day_ago)
    Publishable.find(@publishable.id).to.should eql(tomorrow)
   end
end