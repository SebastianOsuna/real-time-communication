class Message < ActiveRecord::Base
    def as_json(options)
        # don't render updated_at
        super( :only => [:id, :content, :author_id, :author_name], :methods => [:created] )
    end

    def created
        # get timestamp as millis
        created_at.to_i
    end
end
