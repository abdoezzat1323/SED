const mongoose = require('mongoose');

const conversationSchema = mongoose.Schema({
  users: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }],
  // messages: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Message' }],
  createdAt: { type: Date, default: Date.now() },
  lastMessage:{type:String}
});

module.exports = mongoose.model('Conversation', conversationSchema);