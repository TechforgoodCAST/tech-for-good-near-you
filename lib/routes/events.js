require('env2')('./config.env')
const axios = require('axios')

module.exports = {
  method: 'GET',
  path: '/events',
  handler: function (request, reply) {
    axios.get('https://www.eventbriteapi.com/v3/events/search', {
      params: {
        'token': process.env.EVENTBRITE_TOKEN,
        'location.address': request.query.postcode || 'W1T 2EJ',
        'location.within': '10mi',
        'q': 'tech for good',
        'start_date.keyword': 'this_month',
        'expand': 'venue'
      }
    })
    .then(results => reply(results.data.events))
    .catch(err => {
      console.error(err)
      reply(err.response.data.error_description)
    })
  }
}
