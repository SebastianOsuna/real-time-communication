class MessagesController < ApplicationController

    # POST@/messages/
    # @param: content - Message's content
    # @param: author - Author's user ID
    def create
        # find user
        user = User.find_by_id params[:author]
        if user # if exists
            # create message
            msg = Message.new content: params[:content], author_id: user.id, author_name: user.name
            if msg.save # message created
                puts msg.to_json
                render json: { status: 200, response: :OK }
            else # message not created
                render json: { status: 500, response: :ERROR }, status: 500
            end
        else # user not found
            render json: { status: 404, response: :"User not found" }, status: 404
        end
    end

    # GET@/messages/
    # *param: timestamp_init - Get messages created after this timestamp
    def query
        # get timestamp
        time =  params[:timestamp_init] || 0
        # get messages after timestamp
        messages = Message.where( "created_at > ?", DateTime.strptime( time.to_s, "%s" ) ).order( created_at: :desc )
        render json: { messages:  messages, timestamp: DateTime.now.to_i }
    end
end
