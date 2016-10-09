module.exports = {
    
    makeJSON: function () {
	    var dict = {}

	    for(var i = 1; i < 11; i++) {
		    var randomNumber = Math.floor(Math.random() * 1000);
		    var testNum = "Test Number " + i;
		    dict[testNum] = randomNumber;
	    }

	    return dict
    },

		// avoid adding fields to an object... gains 500req/s
    makeJSONfast: function () {
			return {
				"Test Number 1": Math.floor(Math.random() * 1000),
				"Test Number 2": Math.floor(Math.random() * 1000),
				"Test Number 3": Math.floor(Math.random() * 1000),
				"Test Number 4": Math.floor(Math.random() * 1000),
				"Test Number 5": Math.floor(Math.random() * 1000),
				"Test Number 6": Math.floor(Math.random() * 1000),
				"Test Number 7": Math.floor(Math.random() * 1000),
				"Test Number 8": Math.floor(Math.random() * 1000),
				"Test Number 9": Math.floor(Math.random() * 1000),
				"Test Number 10": Math.floor(Math.random() * 1000),
			}
    }
};
