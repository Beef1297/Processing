class Monkey {
  private int tall;
  
  public Monkey() {
    this.tall = (int)random(200, 300);
  }
  public int getTall() {
    return this.tall;
  }
  public void setTall(int tall) {
    this.tall = tall;
    return;
  }
}
