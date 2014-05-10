class User < ActiveRecord::Base
    def as_json(options)
        # don't render timestamps
        super( :only => [:id, :name] )
    end
end
