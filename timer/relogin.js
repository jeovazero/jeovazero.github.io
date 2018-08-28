const URL_GOOGLE ="https://script.google.com/macros/s/AKfycbyd5AcbAnWi2Yn0xhFRbyzS4qMq1VucMVgVvhul5XqS9HkAyJY/exec?tz=America/Fortaleza";

const SC = 1000;
const MN = 60 * SC;
const HR = 60 * MN;
const DY = 24 * HR;

const millito = (ms) => {
    const   days    = Math.trunc(ms / DY),
            hours   = Math.trunc((ms % DY ) / HR),
            minutes = Math.trunc((ms % HR) / MN),
            seconds = Math.trunc((ms % MN) / SC);
    return {
        days,
        hours,
        minutes,
        seconds
    }
}

async function getTime(){
    try{
        let response = await fetch(URL_GOOGLE);
        let json = await response.json();
        console.log(json);
        return json;
    }catch(e){
        console.log(e);
        return e;
    }
};

Vue.component('boxtimer', {
    props: ['ctn', 'lbl'],
    template: `<div class="bt">
                <div class="ctn"> {{ ctn }} </div>
                <div class="sub"> {{ lbl }} </div>
            </div>`
});

Vue.component('relogin', {
    props: ['enddate'],
    data: function(){
        return {
            S: Date.now(),
            E: Date.now(),
            D: millito(new Date().getTime())
        }
    },
    template: `
        <div class="container">
            <boxtimer :ctn="D.days" lbl="dias"></boxtimer>
            <boxtimer :ctn="D.hours" lbl="horas"></boxtimer>
            <boxtimer :ctn="D.minutes" lbl="minutos"></boxtimer>
            <boxtimer :ctn="D.seconds" lbl="segundos"></boxtimer>
        </div>
    `,
    mounted: function(){
        this.S = Date.now();
        this.E = new Date(this.enddate);
        getTime().then( o => {
            this.S = new Date(o.fulldate)
        }).catch(e => {
            console.log(e);
        });
        this.D = millito(this.E - this.S);
        setInterval( () => {
            this.S = Date.now();
            this.D = millito(this.E - this.S);
        },1000);

    }
});

const conversion = (date) => {
    const D = new Date();
    return {
        seconds: D.getSeconds(),
        minutes: D.getMinutes(),
        hours: D.getHours(),
        days: 0
    }
}

const App = new Vue({
    el: '#root'
});




getTime();