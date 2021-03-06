require 'spec_helper'

describe "Lesson" do
  let(:lesson1){ create(:lesson) }
  let(:lesson2){ create(:lesson) }
  let(:lesson3){ create(:lesson, :closed) }
  let(:lesson4){ create(:lesson, :completed) }

  let(:topic_tag1){ create(:tag) }
  let(:topic_tag2){ create(:tag) }
  let(:topic_tag3){ create(:tag) }
  let(:location_tag1){ create(:tag, :location) }
  let(:location_tag2){ create(:tag, :location) }
  let(:time_tag1){ create(:tag, :time) }

  let(:user1){ create(:user) }
  let(:user2){ create(:user) }
  let(:user3){ create(:user) }
  let(:user4){ create(:user) }
  let(:user5){ create(:user) }

  before(:each) do
    lesson1.tags << topic_tag1
    lesson2.tags << topic_tag2
    lesson2.tags << topic_tag3
    lesson2.tags << location_tag1
    lesson4.tags << location_tag1

    lesson1.registrations.create(:user => user1, :role => "student")
    lesson1.registrations.create(:user => user2, :role => "student", :admin => true)
    lesson1.registrations.create(:user => user3, :role => "teacher", :admin => false)
    lesson1.registrations.create(:user => user4, :role => "teacher")
    lesson4.registrations.create(:user => user4, :role => "student")
  end

  describe "::all_by_status" do
    it "can return all lessons of a particular status" do
      expect(Lesson.all_by_status("open").length).to eq(2)
      expect(Lesson.all_by_status("completed")).to include(lesson4)
    end
  end

  describe "#students" do
    it "knows its students" do 
      expect(lesson1.students).to include(user2)
      expect(lesson1.students).to include(user1)
      expect(lesson1.students.length).to eq(2)
    end

    it "returns [] if it has no students" do
      expect(lesson3.students).to eq([])
    end
  end

  describe "#teachers" do
    it "knows its teachers" do
      expect(lesson1.teachers).to include(user3)
      expect(lesson1.teachers).to include(user4)
      expect(lesson1.teachers.length).to eq(2)
    end

    it "returns [] if it has no teachers" do
      expect(lesson3.teachers).to eq([])
    end
  end

  describe "#tags" do
    it "knows what tags it has" do
      expect(lesson1.tags).to include(topic_tag1)
      expect(lesson1.tags).to_not include(topic_tag2)
      expect(lesson1.tags.length).to eq(2)
    end

    it "can have multiple tags" do
      expect(lesson2.tags.length).to eq(4)
    end
  end

  describe "#tags_by_category" do
    it "can return tags of a particular category" do
      expect(lesson2.tags_by_category("location")).to include(location_tag1)
      expect(lesson2.tags_by_category("location").length).to eq(1)
      expect(lesson2.tags_by_category("topic")).to include(topic_tag3)
      expect(lesson2.tags_by_category("topic").length).to eq(3)
    end

    it "returns [] if it has no tags of a particular category" do
      (expect(lesson1.tags_by_category("location")).to eq([]))
    end
  end

  describe "#tag_ids_to_array" do
    it "can return its tag ids as an array" do
      expect(lesson2.tag_ids_to_array).to be_a(Array)
      expect(lesson2.tag_ids_to_array).to include(lesson2.tags.first.id)
    end
  end

    # The following two tests work, but something about FactoryGirl makes it not see tags properly
    describe "#build_tags" do
      it "can add tags to itself, given an array of existing tag_ids as strings" do
        tags_array = ["2", "4", "3"]
        lesson3.build_tags(tags_array)
        lesson3.save

        expect(lesson3.tags).to include(Tag.find(2))
        expect(lesson3.tags).to include(Tag.find(4))
        expect(lesson3.tags.length).to eq(4)
      end
    end

    describe "#admin" do
      it "knows its admin" do
        expect(lesson1.admin).to eq(user2)
        expect(lesson1.admin).to_not eq(user3)
      end

      it "it returns nil if theres no admin" do
        expect(lesson2.admin).to eq(nil)
      end
    end

    describe "#ok_to_delete?" do
      it "verifies user count before deletion" do
        expect(lesson4.ok_to_delete?).to eq(true)
        expect(lesson1.ok_to_delete?).to eq(false)
      end
    end

    describe "#close" do
      it "can close its status" do
        lesson1.close
        expect(lesson1.status).to eq("closed")
      end
    end

    describe "#mark_completed_for_users" do
      xit "can mark itself held" do
        expect(user1).to receive(:add_to_completed).with(lesson1)
      # user1.add_to_completed(lesson1) # This line works, so why doesn't line 158?
      lesson1.mark_completed_for_users
    end
  end

  describe "#specific_time=" do
    it "can parse a string using chronic" do
      time = "monday at noon"
      lesson1.specific_time = time
      expect(lesson1.specific_time).to eq(Chronic.parse("monday at noon"))
      expect(lesson1.specific_time.class).to eq(ActiveSupport::TimeWithZone)
    end

    it "can accept an ActiveRecord datetime" do
      time = Time.now
      lesson1.specific_time = time
      expect(lesson1.specific_time).to eq(time)
      expect(lesson1.specific_time.class).to eq(ActiveSupport::TimeWithZone)
    end
  end


end