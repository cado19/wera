# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190124083731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.index ["subdomain"], name: "index_accounts_on_subdomain"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_carts_on_account_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_categories_on_account_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.bigint "sale_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_customers_on_account_id"
    t.index ["sale_id"], name: "index_customers_on_sale_id"
  end

  create_table "maintenance_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["account_id"], name: "index_owners_on_account_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.decimal "selling_price", precision: 12, scale: 3
    t.decimal "purchase_price", default: "0.0"
    t.integer "quantity", default: 0
    t.bigint "category_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "stockable"
    t.string "manufacturer"
    t.bigint "supplier_id"
    t.boolean "deleted", default: false
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["code"], name: "index_products_on_code"
    t.index ["name"], name: "index_products_on_name"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "quantity"
    t.decimal "total_price", precision: 12, scale: 3
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "owner_id"
    t.index ["account_id"], name: "index_purchases_on_account_id"
    t.index ["owner_id"], name: "index_purchases_on_owner_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sale_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "cart_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.bigint "sale_id"
    t.index ["account_id"], name: "index_sale_items_on_account_id"
    t.index ["cart_id"], name: "index_sale_items_on_cart_id"
    t.index ["product_id"], name: "index_sale_items_on_product_id"
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "pay_type"
    t.decimal "pay_amount", precision: 12, scale: 3
    t.decimal "total", precision: 12, scale: 3
    t.decimal "balance", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.string "code"
    t.bigint "owner_id"
    t.index ["account_id"], name: "index_sales_on_account_id"
    t.index ["owner_id"], name: "index_sales_on_owner_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "email", default: ""
    t.string "telephone", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_suppliers_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "role_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "carts", "accounts"
  add_foreign_key "categories", "accounts"
  add_foreign_key "customers", "accounts"
  add_foreign_key "customers", "sales"
  add_foreign_key "owners", "accounts"
  add_foreign_key "products", "accounts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "purchases", "accounts"
  add_foreign_key "purchases", "owners"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
  add_foreign_key "sale_items", "accounts"
  add_foreign_key "sale_items", "carts"
  add_foreign_key "sale_items", "products"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "accounts"
  add_foreign_key "sales", "owners"
  add_foreign_key "sales", "users"
  add_foreign_key "suppliers", "accounts"
  add_foreign_key "users", "accounts"
  add_foreign_key "users", "roles"
end
