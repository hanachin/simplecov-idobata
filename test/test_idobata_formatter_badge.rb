require 'minitest/autorun'
require 'simplecov/idobata'

describe SimpleCov::Formatter::IdobataFormatter do
  before do
    @result = MiniTest::Mock.new
    @client = MiniTest::Mock.new
    @client.expect(:send, ':D') do |badge, options|
      badge.must_equal @badge_source
      options[:format].must_equal :html
    end
    @formatter = SimpleCov::Formatter::IdobataFormatter.new
  end

  describe 'when covered 90%' do
    before do
      @result.expect(:covered_lines, 9)
      @result.expect(:total_lines, 10)
      3.times { @result.expect(:covered_percent, 90.0) }
    end

    it "should post success badge" do
      @formatter.stub :client, @client do
        @badge_source = (<<-SOURCE).strip
          <span class="label label-success"><i class="fa fa-sun-o"></i> <span class="label label-inverse">9 / 10 LOC (90.0%) covered.</span></span>
        SOURCE
        @formatter.format(@result)
        @client.verify
      end
    end

    describe 'when goal is set to 95%' do
      before do
        @original_goal = SimpleCov::Formatter::IdobataFormatter.goal
        SimpleCov::Formatter::IdobataFormatter.goal = 95.0
      end

      after do
        SimpleCov::Formatter::IdobataFormatter.goal = @original_goal
      end

      it "should post warning badge" do
        @formatter.stub :client, @client do
          @badge_source = (<<-SOURCE).strip
            <span class="label label-warning"><i class="fa fa-umbrella"></i> <span class="label label-inverse">9 / 10 LOC (90.0%) covered.</span></span>
          SOURCE
          @formatter.format(@result)
          @client.verify
        end
      end
    end
  end

  describe 'when covered 80%' do
    before do
      @result.expect(:covered_lines, 8)
      @result.expect(:total_lines, 10)
      3.times { @result.expect(:covered_percent, 80.0) }
    end

    it "should post warning badge" do
      @formatter.stub :client, @client do
        @badge_source = (<<-SOURCE).strip
          <span class="label label-warning"><i class="fa fa-umbrella"></i> <span class="label label-inverse">8 / 10 LOC (80.0%) covered.</span></span>
        SOURCE
        @formatter.format(@result)
        @client.verify
      end
    end

    describe 'when warning is set to 85%' do
      before do
        @original_warning = SimpleCov::Formatter::IdobataFormatter.warning
        SimpleCov::Formatter::IdobataFormatter.warning = 85.0
      end

      after do
        SimpleCov::Formatter::IdobataFormatter.warning = @original_warning
      end

      it "should post failure badge" do
        @formatter.stub :client, @client do
          @badge_source = (<<-SOURCE).strip
            <span class="label label-important"><i class="fa fa-bomb"></i> <span class="label label-inverse">8 / 10 LOC (80.0%) covered.</span></span>
          SOURCE
          @formatter.format(@result)
          @client.verify
        end
      end
    end
  end

  describe 'when covered 79%' do
    before do
      @result.expect(:covered_lines, 79)
      @result.expect(:total_lines, 100)
      3.times { @result.expect(:covered_percent, 79.0) }
    end

    it "should post failure badge" do
      @formatter.stub :client, @client do
        @badge_source = (<<-SOURCE).strip
          <span class="label label-important"><i class="fa fa-bomb"></i> <span class="label label-inverse">79 / 100 LOC (79.0%) covered.</span></span>
        SOURCE
        @formatter.format(@result)
        @client.verify
      end
    end

    describe 'when goal is set to 79%' do
      before do
        @original_goal = SimpleCov::Formatter::IdobataFormatter.goal
        SimpleCov::Formatter::IdobataFormatter.goal = 79.0
      end

      after do
        SimpleCov::Formatter::IdobataFormatter.goal = @original_goal
      end

      it "should post success badge" do
        @formatter.stub :client, @client do
          @badge_source = (<<-SOURCE).strip
            <span class="label label-success"><i class="fa fa-sun-o"></i> <span class="label label-inverse">79 / 100 LOC (79.0%) covered.</span></span>
          SOURCE
          @formatter.format(@result)
          @client.verify
        end
      end
    end
  end
end
