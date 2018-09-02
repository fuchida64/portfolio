require 'rails_helper'

RSpec.describe DefaultStage, type: :model do
	context "データが正しく保存される" do
        before do
            @default_stage = DefaultStage.new
            @default_stage.stage = 1
            @default_stage.period = 2
            @default_stage.user_id = 2
            @default_stage.save
        end
        it "全て入力してあるので保存される" do
            expect(@default_stage).to be_valid
        end
    end
end
