const form = document.getElementById("point-form");
const yInput = document.getElementById("y");
const formError = document.getElementById("form-error");

const canvas = document.getElementById("area-canvas");
const ctx = canvas.getContext("2d");
const canvasError = document.getElementById("canvas-error");

const canvasForm = document.getElementById("canvas-form");
const canvasX = document.getElementById("canvas-x");
const canvasY = document.getElementById("canvas-y");
const canvasR = document.getElementById("canvas-r");

const centerX = canvas.width / 2;
const centerY = canvas.height / 2;
const radiusPixels = 140;

function getSelectedRadius() {
    const selected = document.querySelector('input[name="r"]:checked');

    return selected ? Number(selected.value) : null;
}

function validateForm(event) {
    formError.textContent = "";

    const rawY = yInput.value.trim();

    if (rawY === "") {
        event.preventDefault();
        formError.textContent = "Введите координату Y.";
        return;
    }

    const numberPattern = /^[+-]?(?:\d+(?:\.\d*)?|\.\d+)$/;

    if (!numberPattern.test(rawY)) {
        event.preventDefault();
        formError.textContent = "Y должен быть числом. Используйте точку.";
        return;
    }

    const y = Number(rawY);

    if (!Number.isFinite(y) || y <= -5 || y >= 3) {
        event.preventDefault();
        formError.textContent = "Y должен быть больше -5 и меньше 3.";
        return;
    }

    if (getSelectedRadius() === null) {
        event.preventDefault();
        formError.textContent = "Выберите радиус R.";
    }
}

function drawArea() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = "#3399f3";

    ctx.beginPath();
    ctx.moveTo(centerX, centerY);
    ctx.arc(
        centerX,
        centerY,
        radiusPixels,
        Math.PI,
        1.5 * Math.PI
    );
    ctx.closePath();
    ctx.fill();

    ctx.fillRect(
        centerX - radiusPixels,
        centerY,
        radiusPixels,
        radiusPixels
    );

    ctx.beginPath();
    ctx.moveTo(centerX, centerY);
    ctx.lineTo(centerX + radiusPixels / 2, centerY);
    ctx.lineTo(centerX, centerY - radiusPixels / 2);
    ctx.closePath();
    ctx.fill();

    drawAxes();
    drawSavedPoints();
}

function drawAxes() {
    const r = getSelectedRadius();

    ctx.strokeStyle = "#202838";
    ctx.fillStyle = "#202838";
    ctx.lineWidth = 1;
    ctx.font = "14px Arial";

    ctx.beginPath();
    ctx.moveTo(15, centerY);
    ctx.lineTo(canvas.width - 15, centerY);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(centerX, canvas.height - 15);
    ctx.lineTo(centerX, 15);
    ctx.stroke();

    ctx.fillText("X", canvas.width - 22, centerY - 8);
    ctx.fillText("Y", centerX + 8, 22);

    const fullPositive = r === null ? "R" : String(r);
    const fullNegative = r === null ? "-R" : String(-r);
    const halfPositive = r === null ? "R/2" : String(r / 2);
    const halfNegative = r === null ? "-R/2" : String(-r / 2);

    ctx.fillText(
        fullNegative,
        centerX - radiusPixels - 8,
        centerY - 8
    );

    ctx.fillText(
        halfNegative,
        centerX - radiusPixels / 2 - 14,
        centerY - 8
    );

    ctx.fillText(
        halfPositive,
        centerX + radiusPixels / 2 - 10,
        centerY + 18
    );

    ctx.fillText(
        fullPositive,
        centerX + radiusPixels - 4,
        centerY + 18
    );

    ctx.fillText(
        fullPositive,
        centerX + 8,
        centerY - radiusPixels + 5
    );

    ctx.fillText(
        halfPositive,
        centerX + 8,
        centerY - radiusPixels / 2 + 5
    );

    ctx.fillText(
        halfNegative,
        centerX + 8,
        centerY + radiusPixels / 2 + 5
    );

    ctx.fillText(
        fullNegative,
        centerX + 8,
        centerY + radiusPixels + 5
    );
}

function drawSavedPoints() {
    const selectedR = getSelectedRadius();

    if (selectedR === null) {
        return;
    }

    const rows = document.querySelectorAll(".result-row");

    // Число пикселей на единицу при текущем R.
    const scale = radiusPixels / selectedR;

    rows.forEach((row) => {
        const x = Number(row.dataset.x);
        const y = Number(row.dataset.y);
        const hit = row.dataset.hit === "true";

        if (!Number.isFinite(x) || !Number.isFinite(y)) {
            return;
        }

        // Рисуем исходные координаты в текущем масштабе.
        const pixelX = centerX + x * scale;
        const pixelY = centerY - y * scale;

        ctx.beginPath();
        ctx.arc(pixelX, pixelY, 5, 0, 2 * Math.PI);

        ctx.fillStyle = hit ? "#16833b" : "#bd2532";
        ctx.fill();

        ctx.strokeStyle = "#ffffff";
        ctx.lineWidth = 1.5;
        ctx.stroke();
    });
}

function handleCanvasDoubleClick(event) {
    canvasError.textContent = "";

    const r = getSelectedRadius();

    if (r === null) {
        canvasError.textContent =
            "Невозможно определить координаты: сначала выберите радиус R.";
        return;
    }

    const rect = canvas.getBoundingClientRect();

    const pixelX =
        (event.clientX - rect.left) * canvas.width / rect.width;

    const pixelY =
        (event.clientY - rect.top) * canvas.height / rect.height;

    const scale = radiusPixels / r;

    const x = (pixelX - centerX) / scale;
    const y = (centerY - pixelY) / scale;

    canvasX.value = x.toFixed(4);
    canvasY.value = y.toFixed(4);
    canvasR.value = r;

    canvasForm.requestSubmit();
}

form.addEventListener("submit", validateForm);
canvas.addEventListener("dblclick", handleCanvasDoubleClick);

document.querySelectorAll('input[name="r"]').forEach((radio) => {
    radio.addEventListener("change", () => {
        canvasError.textContent = "";
        drawArea();
    });
});

drawArea();