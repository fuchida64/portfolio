require 'rails_helper'

RSpec.describe MemoryGroup, type: :model do
	context "データが正しく保存される" do
        it "全て入力してあるので保存される" do
        	 memory_group = MemoryGroup.new(id: '1', title: 'pass', content: 'pass', user_id: '1', created_at: '2018-09-01 17:37:01.866014', updated_at: '2018-09-01 17:37:01.866014')
            expect(memory_group).to be_valid
        end
    end
end
