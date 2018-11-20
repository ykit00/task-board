require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a name, email and password" do
    user = FactoryBot.build(:user)

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?

    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid name with more than 30 characters" do
    user = FactoryBot.build(:user, name: "#{ 'a' * 31 }")
    user.valid?

    expect(user.errors[:name]).to include("は30文字以内で入力してください")
  end

  it "is invalid with out a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid incorrect email" do
    user = FactoryBot.build(:user, email: "hogefuga")
    user.valid?

    expect(user.errors[:email]).to include("は不正な値です")
  end

  it "is invalid duplicate email" do
    FactoryBot.create(:user, email: "example@email.com")
    user = FactoryBot.build(:user, email: "example@email.com")
    user.valid?

    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "is invalid with out a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?

    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid password with less than 6 characters" do
    user = FactoryBot.build(:user, password: "hoge")
    user.valid?

    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end
