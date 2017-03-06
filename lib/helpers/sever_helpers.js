module.exports = err => {
  if (err) {
    console.log(`Plugin error: ${err}`);
    throw err
  }
}
