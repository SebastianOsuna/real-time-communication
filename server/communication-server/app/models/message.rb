class Message < ActiveRecord::Base
    def as_json(options)
        # don't render updated_at
        super( :only => [:id, :content, :author_id, :author_name, :created_at] )
    end

    def created_at
        # get timestamp as millis
        super().to_i
    end
end
