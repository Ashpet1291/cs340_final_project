// App.js

/*
    SETUP
*/
    var express = require('express');
    var app = express();
    app.use(express.json())
    app.use(express.urlencoded({extended: true}))
    PORT = 9127;

    // Database
    var db = require('./database/db-connector');

    // Handlebars
    var exphbs = require('express-handlebars');     // Import express-handlebars
    app.engine('.hbs', exphbs({                     // Create an instance of the handlebars engine to process templates
            extname: ".hbs"
    }));
    app.set('view engine', '.hbs');

/*
    ROUTES
*/

    // GET ROUTES
    app.get('/', function(req, res)
        {
            let query1 = `SELECT * FROM Family_Members;`;   // Define our query
            db.pool.query(query1, function(error, rows, fields){
                res.render('familyMembers', {data: rows});
            })
         });

    // POST ROUTES
    app.post('/add-familyMember-form', function(req, res){
        // Capture the incoming data and parse it back to a JS object
        let data = req.body;

        // Capture NULL values
        let nickname = parseInt(data['input-nick_name']);
        if (isNaN(nickname))
        {
            nickname = 'NULL'
        }

        // Create the query and run it on the database
        query1 = `INSERT INTO Family_Members (active, first_name, nick_name, last_name, birthday, primary_number) VALUES ('${data['input-active']}', '${data['input-first_name']}', '${data['input-nick_name']}', '${data['input-last_name']}', '${data['input-birthday']}', '${data['primary_number']}')`;
        db.pool.query(query1, function(error, rows, fields){

            // Check to see if there was an error
            if (error) {

                // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                console.log(error)
                res.sendStatus(400);
            }

            // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
            // presents it on the screen
            else
            {
                res.redirect('/');
            }
        })
    })

    app.delete('/', function (req, res) {
          res.send('Got a DELETE request at /user')
    })

/*
    LISTENER
*/
    app.listen(PORT, function(){
        console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
