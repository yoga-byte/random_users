RSpec.describe InitiateAddUsersDataServiceJob do
  it "adds the enteries to user table" do
    initial_user_count = User.count
    expect(initial_user_count).to be 0
    described_class.perform_now
    expect(User.count).to eq(initial_user_count + 20)
  end
ends