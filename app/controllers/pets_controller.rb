class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.find_or_create_by(params["owner"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    @owner = @pet.owner
    erb :"/pets/edit"
  end

  post '/pets/:id' do
    @owner = Owner.find_by(params["owner"])
    @pet = Pet.find(params[:id])
    @pet.name = params["pet"]["name"]
    @pet.owner = @owner

    if !params["owner_name"].empty?
      @pet.owner = Owner.find_or_create_by(name: params["owner_name"])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
