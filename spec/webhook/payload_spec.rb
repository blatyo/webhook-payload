require 'spec_helper'

describe Webhook::Payload do
  let(:payload){Webhook::Payload.new(payload_data)}
  subject{payload}

  its(:before){should == "5aef35982fb2d34e9d9d4502f6ede1072793222d"}
  its(:after){should == "de8251ff97ee194a289832576287d6f8ad74e3d0"}
  its(:ref){should == "refs/heads/master"}

  it "should have two commits" do
    subject.commits.size.should == 2
  end

  describe "#respository" do
    let(:repository){payload.repository}
    subject{repository}

    its(:url){should == URI.parse("http://github.com/defunkt/github")}
    its(:name){should == "github"}
    its(:pledgie){should be_nil}
    its(:homepage){should be_nil}
    its(:description){should == "You're lookin' at it."}
    its(:watchers){should == 5}
    its(:forks){should == 2}
    its(:private){should == true}

    describe "#owner" do
      subject{repository.owner}

      its(:email){should == "chris@ozmm.org"}
      its(:name){should == "defunkt"}
    end
  end

  describe "a commit" do
    let(:commit){payload.commits.first}
    subject{commit}

    its(:id){should == "41a212ee83ca127e3c8cf465891ab7216a705f59"}
    its(:url){should == URI.parse("http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59")}
    its(:message){should == "okay i give in"}
    its(:timestamp){should == Time.parse("2008-02-15T14:57:17-08:00")}
    its(:added){should == [Pathname.new("filepath.rb")]}
    its(:removed){should == []}
    its(:modified){should == []}

    describe "#author" do
      subject{commit.author}

      its(:email){should == "chris@ozmm.org"}
      its(:name){should == "Chris Wanstrath"}
    end
  end

  let(:payload_data) do
    {
      "before" => "5aef35982fb2d34e9d9d4502f6ede1072793222d",
      "repository" => {
        "url" => "http://github.com/defunkt/github",
        "name" => "github",
        "description" => "You're lookin' at it.",
        "watchers" => 5,
        "forks" => 2,
        "private" => 1,
        "owner" => {
          "email" => "chris@ozmm.org",
          "name" => "defunkt"
        }
      },
      "commits" => [
        {
          "id" => "41a212ee83ca127e3c8cf465891ab7216a705f59",
          "url" => "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
          "author" => {
            "email" => "chris@ozmm.org",
            "name" => "Chris Wanstrath"
          },
          "message" => "okay i give in",
          "timestamp" => "2008-02-15T14:57:17-08:00",
          "added" => ["filepath.rb"]
        },
        {
          "id" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
          "url" => "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
          "author" => {
            "email" => "chris@ozmm.org",
            "name" => "Chris Wanstrath"
          },
          "message" => "update pricing a tad",
          "timestamp" => "2008-02-15T14:36:34-08:00"
        }
      ],
      "after" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
      "ref" => "refs/heads/master"
    }
  end
end