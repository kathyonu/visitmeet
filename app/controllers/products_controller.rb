# frozen_string_literal: true
# code: app/controllers/products_controller.rb
# test: spec/controllers/products_controller_spec.rb
# ref : https://github.com/VisitMeet/visitmeet/blob/master/db/schema.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# == Migrations == last verified accurate 20160424 - ko
#
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160203171325_add_categories_to_product.rb
# db/migrate/20160204160517_add_latitude_longitude_location_to_products.rb
# db/migrate/20160304162257_add_category_id_to_products.rb
# db/migrate/20160304163929_remove_category_from_products.rb
# db/migrate/20160414074100_add_image_to_products.rb
# db/migrate/20160414075549_add_attachment_image_to_products.rb
#
# == Schema Information ==
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  price              :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category           :integer
#  latitude           :float
#  longitude          :float
#  location           :string
#  category_id        :integer
#  image              :string
#  image_file_name    :string
#  image_content_type :string
#  timage_file_size   :integer
#  image_updated_at   :datetime
#
class ProductsController < ApplicationController
  include ActionController::Helpers
  before_action :authenticate_user!, only: [:new]

  def index
    @products = Product.all
    @productscount = Product.all.size
    # //show the markers in the map
    @map_hash = Gmaps4rails.build_markers(@products) do |product, marker|
      marker.lat product.latitude
      marker.lng product.longitude
      marker.infowindow product.title
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Product.categories
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Product.categories
  end

  def create
    @user = current_user
    @categories = Product.categories
    @product = @user.products.build(product_params)
    if @product.save
      flash[:success] = 'New Product Created!'
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    @categories = Product.categories
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :price,
      :user_id,
      :category,
      :category_id,
      :location,
      :latitude,
      :longitude,
      :image,
      :image_file_name,
      :image_content_type,
      :image_file_size,
      :image_updated_at
    )
  end
end
