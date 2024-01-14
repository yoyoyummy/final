import controlP5.*;
ControlP5 cp5;

PGraphics type;
PFont font;

int rect_size = 15;
float rect_factor_x = 1;

boolean sliders_switches = true;

int textR = 255;
int textG = 255;
int textB = 255;
float textSizeValue = 150;

void setup() {
  size(1920, 1080, P2D);
  blendMode(LIGHTEST);

  type = createGraphics(width + 100, height + 100);
  font = createFont("AdobeArabic-Bold-48.vlw", 600);

  cp5 = new ControlP5(this);

  cp5.setColorCaptionLabel(#05FFC2)
    .setColorForeground(#178669)
    .setColorBackground(#24342F)
    .setColorActive(#05FFC2)
    .setColorValueLabel(#05FFC2)
    .setFont(font, 15);

  cp5
    .addSlider("rect_size")
    .setRange(2, 100)
    .setPosition(20, 20)
    .setSize(20, 300)
    .setCaptionLabel("grid");

  cp5
    .addSlider("rect_factor_x")
    .setRange(0, 10)
    .setPosition(80, 20)
    .setSize(20, 300)
    .setCaptionLabel("width");

  cp5
    .addSlider("textR")
    .setRange(0, 255)
    .setPosition(140, 20)
    .setSize(20, 300)
    .setCaptionLabel("Red");

  cp5
    .addSlider("textG")
    .setRange(0, 255)
    .setPosition(200, 20)
    .setSize(20, 300)
    .setCaptionLabel("Green");

  cp5
    .addSlider("textB")
    .setRange(0, 255)
    .setPosition(260, 20)
    .setSize(20, 300)
    .setCaptionLabel("Blue");

  cp5
    .addSlider("textSizeValue")
    .setRange(10, 300)
    .setPosition(320, 20)
    .setSize(20, 300)
    .setCaptionLabel("Text Size");
}

void draw() {
  background(0);
  textR = (int) cp5.getController("textR").getValue();
  textG = (int) cp5.getController("textG").getValue();
  textB = (int) cp5.getController("textB").getValue();
  println(textR);
  println(textG);
  textSizeValue = cp5.getController("textSizeValue").getValue();
  type.beginDraw();
  type.background(0);
  type.fill(textR, textG, textB);
  type.textFont(font);
  type.textSize(textSizeValue);
  type.pushMatrix();
  type.translate(width / 2, height / 2);
  type.textAlign(CENTER, CENTER);
  type.text("processing", 0, 0); //在此行双引号内键入需要像素化的文字
  type.popMatrix();
  type.endDraw();

  PVector number = square_number(rect_size);

  for (int i = 0; i < number.x; i++) {
    for (int i_ = 0; i_ < number.y; i_++) {

      color col = type.get(int(i * rect_size + rect_size / 2), int(i_ * rect_size + rect_size / 2));
      fill(textR, textG, textB);
      if (col == #000000) {
        fill(col);
      }
      strokeWeight(1);
      noStroke();

      rect(i * rect_size, i_ * rect_size, rect_size * rect_factor_x, rect_size);
    }
  }

  if (sliders_switches == true) {
    noFill();
    stroke(#05FFC2);
    strokeWeight(2);
    rect(20, height -rect_size - 20, rect_size, rect_size);
  }
}

PVector square_number(float rect_size_) {
  int rect_size_x = ceil(width / rect_size_) + 3;
  int rect_size_y = ceil(height / rect_size_) + 3;
  PVector number_ = new PVector(rect_size_x, rect_size_y);
  println(number_.x, number_.y);
  return (number_);
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    save("canvas_image.png");
  }
}
