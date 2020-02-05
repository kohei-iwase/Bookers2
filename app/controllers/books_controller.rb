class BooksController < ApplicationController
	def new
		@book = Book.new
	end
	def top
	end
	#booksページの定義、新規投稿機能と一覧機能
	def index
		#投稿機能
		@book = Book.new
		#一覧機能
		@books = Book.all
	end
	#新規投稿機能の定義
	def create
		#ストロングパラメーターのため＠なし
		@book = Book.new(book_params)
		#bookをDBへ保存が成功したら
		if @book.save
			redirect_to book_path(@book.id), notice: "successfully"
		else
			@books = Book.all
			render :index
		end
		#リダイレクト先を詳細画面へ
	end
	#詳細ページの定義
	def show
		@book = Book.find(params[:id])
	end
	#編集ページの定義
	def edit
		@book = Book.find(params[:id])
	end
	#アップデート機能の定義
	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id), notice: "successfully"
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to '/books'
	end

	#ストロングパラメーター
	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
