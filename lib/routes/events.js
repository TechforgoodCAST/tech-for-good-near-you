require('env2')('./config.env')
const axios = require('axios')

const event_ids =
  [ "1277423"
  , "19866282"
  , "18854399"
  , "1302479"
  , "16347132"
  , "22407110"
  , "12205442"
  , "22082866"
  , "2503312"
  , "7975692"
  , "19414181"
  , "18542782"
  , "1635343"
  , "18436868"
  , "19911171"
  , "22216274"
  , "18976100"
  , "17833522"
  , "18037392"
  , "19201419"
  , "22434994"
  , "20399973"
  , "22283959"
  , "14592582"
  , "11072312"
  , "466780"
  , "11972762"
  ]

module.exports = {
  method: 'GET',
  path: '/events',
  handler: function (request, reply) {
    axios.get('https://api.meetup.com/2/events', {
      params: {
        'group_id': event_ids.join(",")
      }
    })
    .then(results => {
      console.log('results', results.data.results);
      reply(results.data.results)
    })
    .catch(err => {
      console.error(err)
      reply(err.response.data.error_description)
    })
  }
}
