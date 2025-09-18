import {readFile} from "node:fs/promises";

export function firstThenApply(seq, pred, fn) {
    for (const s of seq) {
        if (pred(s)) return fn(s);
    }
    return undefined;
}

export function* powersGenerator({ ofBase, upTo }) {
    if (!(ofBase > 0)||!(upTo >= 1)) return;
    let p = 1;
    while (p <= upTo) {
        yield p;
        if (p > Math.floor(upTo / ofBase)) break;
        p *= ofBase;
    }
}

export async function meaningfulLineCount(filename) {
    let text;
    try {
        text = await readFile(filename, "utf8");
    } catch (e) {
        throw new Error(String(e.message || e));
    }
    let n = 0;
    for (const line of text.split(/\r?\n/)) {
        const t = line.trim();
        if (!t) continue;
        if (t[0] === "#") continue;
        n++;
    }
    return n;
}

export function say(first) {
    if (arguments.length === 0) return "";
    const words = [];
    if (typeof first === "string") words.push(first);

    function chain(next) {
        if (arguments.length === 0) {
            return words.join(" ");
        }
        if (typeof next === "string") {
            words.push(next);
            return chain;
        }
        return chain;
    }
    return chain;
}

export class Quaternion {
    constructor (a = 0, b = 0, c = 0, d = 0) {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        Object.freeze(this);
    }

    plus(q) {
        return new Quaternion(
            this.a + q.a,
            this.b + q.b,
            this.c + q.c,
            this.d + q.d
        );
    }

    times(q) {
        const { a, b, c, d } = this;
        const { a: e, b: f, c: g, d: h } = q;
        return new Quaternion(
            a * e - b * f - c * g - d * h,
            a * f + b * e + c * h - d * g,
            a * g - b * h + c * e + d * f,
            a * h + b * g - c * f + d * e
        );
    }

    get coefficients() { 
        return [this.a, this.b, this.c, this.d];
    }

    get conjugate() {
        return new Quaternion(this.a, -this.b, -this.c, -this.d);
    }

    toString() {
        const parts = [];
        const isZero = (x) => x === 0 || Object.is(x, -0);
        const emit = (coef, unit = "") => {
            if (isZero(coef)) return;
            const first = parts.length === 0;
            const neg = coef < 0;
            const abs = Math.abs(coef);
            const sign = first ? (neg ? "-" : "") : (neg ? "-" : "+");
            const mag = unit ? (abs === 1 ? "" : String(abs)) : String(abs);
            parts.push(`${sign}${mag}${unit}`);
        };

        emit(this.a, "");
        emit(this.b, "i");
        emit(this.c, "j");
        emit(this.d, "k");

        return parts.length ? parts.join("") : "0";
    }
}