class GGameBoardsController < ApplicationController
  before_action :set_g_game_board, only: [:show, :edit, :update, :destroy]
  before_action :set_g_game_board_from_game_board_id, only: [:next_turn]

  # Next turn
  def next_turn
    @g_game_board.next_turn
    redirect_to g_game_board_url( @g_game_board )
  end

  # GET /g_game_boards
  # GET /g_game_boards.json
  def index
    @g_game_boards = GGameBoard.all
  end

  # GET /g_game_boards/1
  # GET /g_game_boards/1.json
  def show
    @tokens = @g_game_board.g_game_board_tokens
  end

  # GET /g_game_boards/new
  def new
    @g_game_board = GGameBoard.new
  end

  # GET /g_game_boards/1/edit
  def edit
  end

  # POST /g_game_boards
  # POST /g_game_boards.json
  def create
    @g_game_board = GGameBoard.new(g_game_board_params)

    # By default : stark vs lannister
    major_houses_code_name = %w( stark lannister )

    respond_to do |format|
      if @g_game_board.save
        HHouse.suzerains.each do |house|
          if major_houses_code_name.include?( house.code_name )
            @g_game_board.declare_major_houses( house )
          else
            @g_game_board.declare_minor_houses( house )
          end
        end

        @g_game_board.refresh_tokens

        format.html { redirect_to @g_game_board, notice: 'G game board was successfully created.' }
        format.json { render :show, status: :created, location: @g_game_board }
      else
        format.html { render :new }
        format.json { render json: @g_game_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /g_game_boards/1
  # PATCH/PUT /g_game_boards/1.json
  def update
    respond_to do |format|
      if @g_game_board.update(g_game_board_params)
        format.html { redirect_to @g_game_board, notice: 'G game board was successfully updated.' }
        format.json { render :show, status: :ok, location: @g_game_board }
      else
        format.html { render :edit }
        format.json { render json: @g_game_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /g_game_boards/1
  # DELETE /g_game_boards/1.json
  def destroy
    @g_game_board.destroy
    respond_to do |format|
      format.html { redirect_to g_game_boards_url, notice: 'G game board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_g_game_board
      @g_game_board = GGameBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def g_game_board_params
      params.fetch(:g_game_board, {})
    end
end
