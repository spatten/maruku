require File.dirname(__FILE__) + "/spec_helper"

describe "#to_md" do
  context "for a document with a header" do
    before(:each) do
      @doc = Maruku.new("# Chapter 1\n\nIt was a dark and stormy night.\n## Section 1\n\nSuddenly, a shot rang out")
      @md = @doc.to_md
    end

    it "should print a level 1 header for chapter 1" do
      @md.should match %r{# Chapter 1}
    end

    it "should print a level 2 header for section 1" do
      @md.should match %r{## Section 1}
    end

    it "should put a blank line after the header" do
      @md.should match /# Chapter 1\n\nIt/m
    end
  end

  context "for a document with an inline link" do
    before(:each) do
      @original_md = "This [is a link](http://www.example.com) of epic proportions"
      @doc = Maruku.new(@original_md)
      @md = @doc.to_md
    end

    it "should output a Markdown link" do
      @md.should match %r{\[is a link\]\(http:\/\/www.example.com\)}
    end

    it "should have the stuff before the link in front of the link" do
      @md.should match %r{This \[}
    end

    it "should have the stuff after the link after the link" do
      @md.should match %r{\)\sof epic}
    end

  end

  context "for a document with a reference link" do
    before(:each) do
      @original_md = "This [is a link][example] of epic proportions.\n\n[example]: http://www.example.com\n"
      @doc = Maruku.new(@original_md)
      @md = @doc.to_md
    end

    it "should contain the link" do
      @md.should match /\[is a link\]\[example\]/
    end

    it "should contain the reference" do
      @md.should match /\[example\]\s?http:\/\/www\.example\.com/
    end

    it "should be pretty" do
      puts "original:\n#{@original_md}"
      puts "final:\n#{@md}"
      puts "doc:\n#{@doc.inspect}"
    end
  end

  context "for a quote" do
    before(:each) do
      @original_md = "Here is a quote:\n>  \n> line one\n>  \n> line two\n>  \n> line three\n\nthe end."
      @doc = Maruku.new(@original_md)
      @md = @doc.to_md      
    end

    it "should be pretty" do
      puts "original:\n#{@original_md}"
      puts "final:\n#{@md}"
      puts "doc:\n#{@doc.inspect}"
    end
  end

  context "for something more complicated" do
    before(:each) do
      @original_md = <<-MARKDOWN
# Chapter 1

It was a *dark* and **stormy** night.

suddenly a shot rang out!

<http://www.cliche.com>

> What am I *talking* about, this is crazy!
> well, see what I mean?
> Hmph.

MARKDOWN
      @doc = Maruku.new(@original_md)
      @md = @doc.to_md      
    end

    it "should be pretty" do
      puts "original:\n#{@original_md}"
      puts "final:\n#{@md}"
      puts "doc:\n#{@doc.inspect}"
    end  end
end
