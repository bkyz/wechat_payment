class WechatPayment::GoodsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :user, type: :string, default: :user

  def add_concern_to_goods
    goods_model_head_one = "class #{name.to_s.camelize} < ApplicationRecord"
    inject_into_file goods_model_file, after: goods_model_head_one do
      <<~GOODS_CONCERN
include WechatPayment::Concern::Goods
      GOODS_CONCERN
    end
  end

  def add_concern_to_users
    user_model_head_one = "class #{user_model_name} < ApplicationRecord"
    inject_into_file user_model_file, after: user_model_head_one do
      <<~USERS_CONCERN
include WechatPayment::Concern::Users
      USERS_CONCERN
    end
  end

  def add_concern_to_user_goods
    user_goods_model_head_one = "class #{user_goods_model_name} < ApplicationRecord"
    inject_into_file user_goods_model_file, after: user_goods_model_head_one do
      <<~USER_GOOD_CONCERN
include WechatPayment::Concern::UserGoods
      USER_GOOD_CONCERN
    end
  end

  private

  def goods_model_file
    "app/models/#{name.underscore}.rb"
  end

  def user_model_file
    "app/models/#{options[:user].underscore}"
  end

  def user_goods_model_file
    "app/models/#{options[:user].underscore}_#{name.underscore}"
  end

  def goods_model_name
    name.camelize
  end

  def user_model_name
    options[:user].camelize
  end

  def user_goods_model_name
    user_model_name + goods_model_name
  end
end