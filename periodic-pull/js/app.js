(function(){
    var SERVER = "http://localhost:3000";
    var stream = $( "#message-stream" );
    var timestamp = 0;
    var lastIds = [];
    var userId;

    var post_message = function( message ) {
        if( message ) {
            $.ajax({
                url: SERVER + "/messages",
                data: {
                    author: userId,
                    content: message
                },
                type: "POST"
            }).done( function() {
                $("#new-message").val( '' );
            });
        }
    };
    
    var load_messages_since = function( time, prepend ) {
        $.get( SERVER + "/messages?timestamp_init="+time ).done( function( data ) {
            set_timestamp( data.timestamp );
            $( data.messages ).each( function( i, m ) {
                if( lastIds.indexOf( m.id ) < 0 ) {
                    render_message( m, prepend );
                    lastIds.push( m.id );
                }
            } );
        } );
    };

    var render_message = function( msg, prepend ) {
        var date = new Date( parseInt( msg.created )*1000 );
        var li = $( "<li>" ).attr( { class: "message" } ).append(
            $( "<span>" ).attr( { class: "message-content" } ).text( msg.content )
        ).append(
            $( "<span>" ).attr( { class: "message-author" } ).text( msg.author_name )
        ).append(
            $( "<span>" ).attr( { class: "message-date" } ).text( date.toUTCString() )
        );
        if( prepend == undefined ) {
            stream.append( li );
        } else {
            stream.prepend( li );
        }
    };

    var set_timestamp = function( millis ) {
        timestamp = millis;
        $( "#last-pull" ).text( new Date( timestamp*1000 ).toUTCString() );
    };

    var get_identity = function( callback ) {
        $.ajax({
            url: SERVER + "/users",
            data: { username: $( "#author-name" ).val() },
            type: "POST"
        }).done( function( user ) {
            userId = user.id;
            callback();
        } );
    };

    $( "#send-message" ).click( function() {
        if( userId ) {
            post_message( $( "#new-message" ).val() );
        } else if( $( "#author-name" ).val() ) {
            get_identity( function() { post_message( $( "#new-message" ).val() ); } );
        } else {
            alert( 'You must identify first!' );
        }
    } );

    // load for first time
    load_messages_since( timestamp );
    // define the periodic pull
    var pull = function() {
        setTimeout( function() {
            load_messages_since( timestamp, "prepend" );
            pull();
        }, 1000 );
    };
    // start polling
    pull();

})();