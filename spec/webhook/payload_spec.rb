require 'spec_helper'

describe Webhook::Payload do
  describe ".from_json" do
    let(:payload_data){{'cool' => 'neat'}}
    let(:json){'{"cool": "neat"}'}

    it "should create a new Webhook::Payload after converting the json passed into ruby literals" do
      Webhook::Payload.should_receive(:new).with(payload_data)

      Webhook::Payload.from_json(json)
    end
  end

  describe "with sample payload data" do
    let(:payload){Webhook::Payload.new(payload_data)}
    subject{payload}

    its(:before){should == "5aef35982fb2d34e9d9d4502f6ede1072793222d"}
    its(:after){should == "de8251ff97ee194a289832576287d6f8ad74e3d0"}
    its(:ref){should == "refs/heads/master"}
    its(:compare){should == "https://github.com/defunkt/github/compare/5aef35982fb2^...de8251ff97ee"}
    its(:created){should == false}
    its(:deleted){should == false}
    its(:forced){should == false}

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
      its(:stargazers){should == 1}
      its(:fork){should == true}
      its(:forks){should == 2}
      its(:private){should == true}
      its(:has_downloads){should == true}
      its(:has_issues){should == true}
      its(:has_wiki){should == true}
      its(:language){should == "Ruby"}
      its(:master_branch){should == "master"}
      its(:open_issues){should == 12}
      its(:size){should == 2156}
      its(:created_at){should == DateTime.new(2012, 3, 28, 23, 36, 8)}
      its(:pushed_at){should == DateTime.new(2013, 3, 14, 21, 12, 0)}

      describe "#owner" do
        subject{repository.owner}

        its(:email){should == "chris@ozmm.org"}
        its(:name){should == "Chris Wanstrath"}
        its(:username){should == "defunkt"}
      end
    end

    describe "a commit" do
      let(:commit){payload.commits.first}
      subject{commit}

      its(:id){should == "41a212ee83ca127e3c8cf465891ab7216a705f59"}
      its(:distinct){should == true}
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
        its(:username){should == "defunkt"}
      end

      describe "#committer" do
        subject{commit.committer}

        its(:email){should == "chris@ozmm.org"}
        its(:name){should == "Chris Wanstrath"}
        its(:username){should == "defunkt"}
      end
    end

    describe "#pusher" do
      subject{payload.pusher}

      its(:name){should == "none"}
    end

    describe "#head_commit" do
      subject{payload.head_commit}

      its(:id){should == "de8251ff97ee194a289832576287d6f8ad74e3d0"}
      its(:distinct){should == true}
      its(:url){should == URI.parse("http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0")}
      its(:message){should == "update pricing a tad"}
      its(:timestamp){should == Time.parse("2008-02-15T14:36:34-08:00")}
      its(:added){should == []}
      its(:removed){should == []}
      its(:modified){should == []}

      describe "#author" do
        subject{payload.head_commit.author}

        its(:email){should == "chris@ozmm.org"}
        its(:name){should == "Chris Wanstrath"}
        its(:username){should == "defunkt"}
      end

      describe "#committer" do
        subject{payload.head_commit.committer}

        its(:email){should == "chris@ozmm.org"}
        its(:name){should == "Chris Wanstrath"}
        its(:username){should == "defunkt"}
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
          "stargazers" => 1,
          "fork" => true,
          "forks" => 2,
          "private" => 1,
          "owner" => {
            "email" => "chris@ozmm.org",
            "name" => "Chris Wanstrath",
            "username" => "defunkt"
          },
          "created_at" => 1332977768,
          "has_downloads" => true,
          "has_issues" => true,
          "has_wiki" => true,
          "language" => "Ruby",
          "master_branch" => "master",
          "open_issues" => 12,
          "pushed_at" => 1363295520,
          "size" => 2156
        },
        "commits" => [
          {
            "id" => "41a212ee83ca127e3c8cf465891ab7216a705f59",
            "distinct" => true,
            "url" => "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
            "author" => {
              "email" => "chris@ozmm.org",
              "name" => "Chris Wanstrath",
              "username" => "defunkt"
            },
            "committer" => {
              "email" => "chris@ozmm.org",
              "name" => "Chris Wanstrath",
              "username" => "defunkt"
            },
            "message" => "okay i give in",
            "timestamp" => "2008-02-15T14:57:17-08:00",
            "added" => ["filepath.rb"]
          },
          {
            "id" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
            "distinct" => true,
            "url" => "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
            "author" => {
              "email" => "chris@ozmm.org",
              "name" => "Chris Wanstrath",
              "username" => "defunkt"
            },
            "committer" => {
              "email" => "chris@ozmm.org",
              "name" => "Chris Wanstrath",
              "username" => "defunkt"
            },
            "message" => "update pricing a tad",
            "timestamp" => "2008-02-15T14:36:34-08:00"
          }
        ],
        "after" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
        "ref" => "refs/heads/master",
        "compare" => "https://github.com/defunkt/github/compare/5aef35982fb2^...de8251ff97ee",
        "created" => false,
        "deleted" => false,
        "forced" => false,
        "head_commit" => {
          "id" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
          "distinct" => true,
          "url" => "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
          "author" => {
            "email" => "chris@ozmm.org",
            "name" => "Chris Wanstrath",
            "username" => "defunkt"
          },
          "committer" => {
            "email" => "chris@ozmm.org",
            "name" => "Chris Wanstrath",
            "username" => "defunkt"
          },
          "message" => "update pricing a tad",
          "timestamp" => "2008-02-15T14:36:34-08:00"
        },
        "pusher" => {
          "name" => "none"
        }
      }
    end
  end
end
