// PageBotAI Chatbot
(function() {
    var script = document.createElement("script");
    script.src = "https://pagebotai.lisekarimi.com/static/embed.js";
    script.onload = function() {
        initializePageBotAI({
            chatbotName: 'CureTrackBot',
            primaryColor: '#7b79d3',
            instructions: 'You are a helpful AI assistant that answers questions based on the content of the websites you can access. Be friendly, concise, and accurate in your responses.',
            targetUrls: ['https://curetrack.lisekarimi.com'],
            wsUrl: 'https://pagebotai.lisekarimi.com/ws/chat'
        });
    };
    document.head.appendChild(script);
})();
// End of PageBotAI Chatbot
