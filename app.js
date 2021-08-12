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

    app.use(express.static(__dirname +'/img'));

/*
    ROUTES
*/

// GET ROUTES
    // get route to display home page
    app.get('/', function(req,res)
        {
            res.render('index');
        });

    // get route to display family members page- which displays members of a family and thier associated data
    app.get('/familyMembers', function(req, res)
        {
            let query1;

            if (req.query.last_name == undefined)
            {
                query1 = "SELECT * FROM Family_Members;";   // Define our query
            }
            else
            {
                query1 = `SELECT * FROM Family_Members WHERE last_name LIKE "${req.query.last_name}%"`
            }

            let query2 = "SELECT * FROM Family_Members;";
            db.pool.query(query1, function(error, rows, fields){

                let fmembers = rows;

                db.pool.query(query2, (error, rows, fields) => {

                return res.render('familyMembers', {data: fmembers});
                })
            })
         });

    // Get route to display the announcements page
    app.get('/announcements', function(req, res)
        {
            let context = {}
            context.jsscripts = ["deleteAnnouncements.js"];
            let query1 = "SELECT * FROM Announcements;";
            db.pool.query(query1, function(error, rows, fields){
                res.render('announcements', {data: rows});
            })
        });

    // Get route to display places page
    app.get('/places', function(req, res)
        {
            let query1 = "SELECT * FROM Places;";
            db.pool.query(query1, function(error, rows, fields){
                res.render('places', {data: rows});
            })
        });
    // get route to display items page and info
    app.get('/items', function(req, res)
        {
            let query2 = "SELECT * FROM Items;";
            db.pool.query(query2, function(error, rows, fields){
                res.render('items', {data: rows});
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
                res.redirect('/familyMembers');
            }
        })
    })

        app.delete('/announcements/:id', function (req, res) {
            let sql = "DELETE FROM Announcements WHERE announcement_id = ?";
            let inserts = [req.params.id];
            sql = db.pool.query(sql, inserts, function(error, results, fields){
                if(error){
                    res.write(JSON.stringify(error));
                    res.status(400)
                    res.end();
                }else{
                    res.status(202).end()
            }
        })
    })


    // route for announcements
    app.post('/add-announcement-form', function(req, res){
        // Capture the incoming data and parse it back to a JS object
        let data = req.body;

        // Create the query and run it on the database
         query1 = `INSERT INTO Announcements (active, title, note, start_date, end_date, announcement_owner) VALUES ('${data['input-active']}', '${data['input-title']}', '${data['input-note']}', '${data['input-startDate']}', '${data['input-endDate']}', '${data['input-aowner']}')`;
         db.pool.query(query1, function(error, rows, fields){

             // Check to see if there was an error
             if (error) {
                 console.log(error)
                 res.sendStatus(400);
             }

             else
             {
                 res.redirect('/announcements');
             }
         })
    })

    app.post('/add-item-form', function(req, res){
        let data = req.body;

        query2 = `INSERT INTO Items  (active, item_name, item_amount, suggested_store, note, item_owner) VALUES ('${data['input-active']}', '${data['input-itemName']}', '${data['input-itemAmount']}', '${data['input-suggStore']}', '${data['input-note']}', '${data['input-itemOwner']}')`;
        db.pool.query(query2, function(error, rows, fields){

            if(error) {

                console.log(error)
                res.sendStatus(400);
            }

            else {
                res.redirect('/items');
            }
        })
    })


    app.post('/add-place-form', function(req, res){
        let data = req.body;

        let website = data['input-website'];
        if (isNaN(website))
            {
                website = 'NULL'
            }

        query2 = `INSERT INTO Places (active, name, website, indoor, note) VALUES ('${data['input-active']}', '${data['input-name']}', ${website}, '${data['input-indoor']}', '${data['input-note']}')`;
        db.pool.query(query2, function(error, rows, fields){

        if (error) {

            console.log(error)
            res.sendStatus(400);
        }

        else
        {
            res.redirect('/places');
        }
    })
    })



/*
    LISTENER
*/
    app.listen(PORT, function(){
        console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
