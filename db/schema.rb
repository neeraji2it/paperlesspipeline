# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130729115248) do

  create_table "agents", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "user_id"
    t.boolean  "listing"
    t.boolean  "selling"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "checklists", :force => true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "created_by"
    t.integer  "transaction_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.text     "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.integer  "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "user_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "location_id"
    t.string   "document_type"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "note"
    t.integer  "transaction_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "checklist_id"
    t.string   "name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "transaction_id"
    t.boolean  "status",         :default => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.string   "transaction_name"
    t.string   "transaction_number"
    t.string   "status"
    t.date     "close_date"
    t.text     "more_info"
    t.date     "automatic_expire_date"
    t.string   "buyer_name"
    t.string   "seller_name"
    t.string   "list_price"
    t.string   "sale_price"
    t.string   "total_commission"
    t.string   "commission_summary"
    t.string   "listing"
    t.string   "selling"
    t.string   "outside_listing_agent_name"
    t.string   "outside_selling_agent_name"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "location_id"
    t.date     "expiration_date"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                       :default => "", :null => false
    t.string   "encrypted_password",          :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "name"
    t.string   "allow_pdf"
    t.boolean  "pdf_documents"
    t.boolean  "email_transaction_reminders"
    t.boolean  "entered_docs_feature"
    t.boolean  "duplicate_document_uploads"
    t.boolean  "is_admin"
    t.string   "location"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "active"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.integer  "phone_number"
    t.integer  "create_id"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
