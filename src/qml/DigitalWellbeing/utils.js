.pragma library

function genColor(k) {
    const colors = ['#51a1ff', '#c7bbfa', '#ff8a7f', '#ffa671', '#ffe575', '#baf86e']
    return colors[k % colors.length]
}
function getPercent(percent) {
    return `${(percent * 100).toFixed(2)}%`
}
function getTimeString(secs) {
    const mins = Math.floor((secs / 60) % 60)
    const hours = Math.floor((secs / 3600))
    return (hours ? `${hours}h ` : '') + (mins ? `${mins}min` : '<1min')
}
var cnt = 0
function initColor() {
    cnt = 0
}
function nextColor() {
    return genColor(cnt++)
}
function toDateTime(secs) {


    /*
    const sec = Math.floor(secs % 60)
    const mins = Math.floor((secs / 60) % 60)
    const hours = Math.floor((secs / 3600))
    const str = `${hours}:${mins}:${sec}`
    return Date.fromLocaleString(Qt.locale(), str, 'hh:mm:ss')*/
    console.warn(Date(secs))
    return Date(secs)
}
