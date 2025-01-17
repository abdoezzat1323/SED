const Category = require('../models/category');
const mongoose = require('mongoose');

mongoose.set('strictQuery', true);
mongoose.connect('mongodb+srv://admin:admin@cluster0.qoxzbzd.mongodb.net/?retryWrites=true&w=majority',{ useNewUrlParser: true, useUnifiedTopology: true }).then(()=>{console.log('Connected Successfully To SED Database')})


const SedCategories = [
    new Category({
        _id: 1,
        name: "Electronics",
        image: "https://th.bing.com/th/id/OIP.L6tQukboSOphUDypf9Ef2gHaKJ?pid=ImgDet&rs=1"
    }),
    new Category({
        _id: 2,
        name: "Fashion",
        image: "https://www.i2clipart.com/cliparts/5/5/a/2/clipart-gown-512x512-55a2.png"
    }),
    new Category({
        _id: 3,
        name: "Phones & Tablets",
        image: "https://th.bing.com/th/id/R.fb20e43b4f946b15e473114f4cc7f3d5?rik=v61SWJX7exeKMQ&pid=ImgRaw&r=0"
    }),
    new Category({
        _id: 4,
        name: "Books",
        image: "https://th.bing.com/th/id/R.875b7e9bc007fbd292c070ac9735ef6a?rik=NkfIsfiwzk%2br5g&riu=http%3a%2f%2fmarvistamom.com%2fwp-content%2fuploads%2fbooks3.jpg&ehk=45OcK5XC3hHbUte6%2frEAdckJ2n%2bdSAASyFXEw0EOXZ8%3d&risl=&pid=ImgRaw&r=0"
    }),
    new Category({
        _id: 5,
        name: "Furniture",
        image: "https://th.bing.com/th/id/OIP.oHZQ_0mrIM0UFuWeV8KdCAHaID?pid=ImgDet&rs=1"
    }),
    new Category({
        _id: 6,
        name: "Supermarket",
        image: "https://th.bing.com/th/id/R.4671aa75b5ca324a3513afdbed57109b?rik=YQhAThDuAWKQYQ&pid=ImgRaw&r=0"
    }),
    new Category({
        _id: 7,
        name: "Body & Health Care",
        image: "https://th.bing.com/th/id/OIP.OtJ4UWmcrWFWQo8I2K1M9QHaHa?pid=ImgDet&rs=1"
    }),
    new Category({
        _id: 8,
        name: "Sports",
        image: "https://th.bing.com/th/id/OIP.JcFY9NUq0LdgxZc-vBXPewHaHa?pid=ImgDet&rs=1"
    }),
    new Category({
        _id: 9,
        name: "Vehicles",
        image: "https://th.bing.com/th/id/R.10bc4790ede4bb677dc3c06ec7c37319?rik=UBY3GJmDK5OB5A&riu=http%3a%2f%2fdigestcars.com%2fwp-content%2fuploads%2f2019%2f12%2fcar-2.jpg&ehk=YnoaW1KEXTtsQfOea2VPf2rZszEggrXVtLKILEMuO%2bM%3d&risl=&pid=ImgRaw&r=0"
    }),
    new Category({
        _id: 10,
        name: "Others",
        image: "https://th.bing.com/th/id/R.aa7bb005e0ae46b9d926678338276352?rik=kGKZV5x8YQlQPQ&riu=http%3a%2f%2fwww.emergtest.com%2fimages_sites%2fothers_logo.png&ehk=ltHmyX%2fMrCxdgUvEAqdxcuvHF1Qyye%2brzOFWvqVyaaI%3d&risl=&pid=ImgRaw&r=0"
    }),
];

var done = 0;

for (var i = 0; i < SedCategories.length; i++) {
    SedCategories[i].save().
    then(doc=>{
        done++
        console.log('added');
        if (done === SedCategories.length) {
            mongoose.disconnect();
        };
    }).catch(err=>{
        console.log(err);
        mongoose.disconnect();
    });
};
