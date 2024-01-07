class Halving {
  int blocks = 0;
  int days = 0;

  Halving({
    this.blocks = 0,
    this.days = 0,
  });

  Halving getHalvingTimer(int lastBlock) {
    int halvingTimer;
    if (lastBlock < 210000) {
      halvingTimer = 210000 - lastBlock;
    } else if (lastBlock < 420000) {
      halvingTimer = 420000 - lastBlock;
    } else if (lastBlock < 630000) {
      halvingTimer = 630000 - lastBlock;
    } else if (lastBlock < 840000) {
      halvingTimer = 840000 - lastBlock;
    } else if (lastBlock < 1050000) {
      halvingTimer = 1050000 - lastBlock;
    } else if (lastBlock < 1260000) {
      halvingTimer = 1260000 - lastBlock;
    } else if (lastBlock < 1470000) {
      halvingTimer = 1470000 - lastBlock;
    } else if (lastBlock < 1680000) {
      halvingTimer = 1680000 - lastBlock;
    } else if (lastBlock < 1890000) {
      halvingTimer = 1890000 - lastBlock;
    } else if (lastBlock < 2100000) {
      halvingTimer = 2100000 - lastBlock;
    } else {
      halvingTimer = 0;
    }

    int timeRemaining = halvingTimer * 600;
    int timeRemainingDays = ((timeRemaining / (60 * 60 * 24))).ceil();

    return Halving(blocks: halvingTimer, days: timeRemainingDays);
  }
}
