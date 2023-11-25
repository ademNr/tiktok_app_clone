// models/video.js
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const VideoSchema = new Schema({
    userId : {type : String } , 
    name: { type: String, required: true },
    filePath: { type: String, required: true },
    createdAt: { type: Date, default: Date.now },
});

const Video = mongoose.model('Video', VideoSchema);

module.exports = Video;