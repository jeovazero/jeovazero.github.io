const URL_GOOGLE ="https://script.google.com/macros/s/AKfycbyd5AcbAnWi2Yn0xhFRbyzS4qMq1VucMVgVvhul5XqS9HkAyJY/exec?tz=America/Fortaleza";

const SC = 1000;
const MN = 60 * SC;
const HR = 60 * MN;
const DY = 24 * HR;

const FD = (len, number) => (new Array(len).fill('0').join('') + number).slice(-len);
const F2 = (number) => FD(2, number);

const millito = (ms) => {
    const   days    = Math.trunc(ms / DY),
            hours   = F2(Math.trunc((ms % DY ) / HR)),
            minutes = F2(Math.trunc((ms % HR) / MN)),
            seconds = F2(Math.trunc((ms % MN) / SC));
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
                <div class="lbl"> {{ lbl }} </div>
            </div>`
});

Vue.component('relogin', {
    props: ['enddate'],
    data: function(){
        return {
            S: Date.now(),
            E: Date.now(),
            D: millito(new Date().getTime()),
            U: null,
            F: true
        }
    },
    template: `
        <div class="relogin">
            <boxtimer :ctn="D.days" lbl="dias"></boxtimer>
            <div class="spt"></div>
            <boxtimer :ctn="D.hours" lbl="horas"></boxtimer>
            <div class="spt"></div>
            <boxtimer :ctn="D.minutes" lbl="minutos"></boxtimer>
            <div class="spt"></div>
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
        if(this.updateD()){
            this.U = setInterval( () => {
                this.S = Date.now();
                if(!this.updateD()){
                    clearInterval(this.U);
                }
            },1000);
        }

    },
    methods: {
        updateD: function(){
            let diff = this.E - this.S;
            this.D = millito(Math.max(diff, 0));
            return (diff <= 0) ? this.final() : true;
        },
        final: function(){
            this.F = false;
            return false;
        }
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