require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do
    describe 'GET movies_director' do 
        it "should get called with apt parameters" do
            mv1 = Movie.new
            mv2 = Movie.new
            fake_results=[mv1,mv2]
            director = "ABC"
            title = "Alien"
    
            Movie.should_receive(:get_movies_director).with(director).and_return(fake_results)
    
            get :movies_director, :director => director, :title => title
        end
        it "should render movies_director with same director movies" do
            mv1 = double("movie 2")
            mv2 = double("movie 1")
            fake_results=[mv1,mv2]
            director = "ABC"
            title = "Alien"
    
            Movie.stub(:get_movies_director).with(director).and_return(fake_results)
    
            get :movies_director, :director => director, :title => title
            response.should render_template('movies_director')
    
        end
        it "should redirect_to home page when no director" do
        title = "Alien"
        get :movies_director, :director => nil, :title => title
        response.should redirect_to('/movies')
        end

    end
    
    describe 'shows details of a single movie' do
        it 'shows info about the selected movie' do
            mv1 = double('movie 1')
            Movie.should_receive(:find).with('1').and_return(mv1)
            get :show, :id => '1'
            expect(response).to render_template(:show)
        end
    end
    
    describe 'allow creating a movie' do
        it 'should create a movie given all params' do
            movie_params = {'director' => '', 'title' => 'Movie Title'}
            mv1 = double('movie 1', :director => '', :title => 'Movie Title')
            Movie.should_receive(:create!).and_return(mv1)
            
            post :create, :movie => movie_params
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'allow deleting a movie' do
        it 'should redirect to movies list after deleting a movie' do
            mv1 = double('movie 1', :director => '', :title => 'Movie Title')
            Movie.should_receive(:find).with('1').and_return(mv1)
            mv1.should_receive(:destroy)
            delete :destroy, :id => '1'
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'allow editing a movie' do
        it 'should get the form to edit a movie given id' do
            mv1 = double('movie 1', :director => '', :title => 'Movie Title')
            Movie.should_receive(:find).with('1').and_return(mv1)
            get :edit, :id => '1'
            expect(response).to render_template(:edit)
        end
    end
    
    describe 'allow updating a movie' do
        it 'should update the movie given all params' do
            mv1 = double('movie 1', :director => '', :title => 'Movie Title')
            movie_params = {'director' => '', 'title' => 'Movie Title'}
            Movie.should_receive(:find).with('1').and_return(mv1)
            mv1.should_receive(:update_attributes!)
            get :update, :id => '1', :movie => movie_params
            expect(response).to redirect_to(movie_path(mv1))
        end
    end
    
    describe 'all movies list' do
        it 'should show the list of all movies upon loading the homepage' do
            movies = [double('movie_1'), double('movie_2')]
        end
    end
end