var Game = createReactClass({
    getInitialState: function () {
        return {
            pointA: 10,
            pointB: 20,
            gamerAShip: 'A',
            gamerAMine: 'B',
            gamerBShip: 'A',
            gamerBMine: 'B',
            gameFinished: false,
            showTip: 'no'
        }
    },

    startNewGame: function(event) {
        event.preventDefault();

        this.setState({
            gamerAShip: 'A',
            gamerAMine: 'B',
            gamerBShip: this.randomField(),
            gamerBMine: this.randomField(),
            gameFinished: false
        })
    },

    randomField: function() {
        return ['A', 'B'][Math.floor(Math.random() * 2)];
    },

    handleChangePointA: function(event) {
        this.setState({
            pointA: parseInt(event.target.value)
        })
    },

    handleChangePointB: function(event) {
        this.setState({
            pointB: parseInt(event.target.value)
        })
    },

    runGame: function() {
        this.setState({
            gameFinished: true
        })
    },

    handleShipChange: function (changeEvent) {
        this.setState({
            gamerAShip: changeEvent.target.value
        });
    },

    handleMineChange: function (changeEvent) {
        this.setState({
            gamerAMine: changeEvent.target.value
        });
    },

    handleTipChange: function(changeEvent) {
        this.setState({
            showTip: changeEvent.target.value
        });
    },

    combinations: function () {
        var self = this;
        var options = [['A', 'A'], ['A', 'B'], ['B', 'B'], ['B', 'A']];

        var matrix = [];
        for (i = 0; i < options.length; i++) {
            var row = [];
            for (j = 0; j < options.length; j++) {
                row.push([
                    self.gamerPoints(options[i][0], options[i][1], options[j][0], options[j][1]),
                    self.gamerPoints(options[j][0], options[j][1], options[i][0], options[i][1])
                ])
            }
            matrix.push(row);
        }

        return matrix;
    },

    gamerPoints: function(aShip, aMine, bShip, bMine) {
        var self = this.state;
        if (aMine == aShip && bShip == bMine && aMine == bShip) {
            return 0;
        }
        if (aMine == aShip && aMine == bShip && bShip != bMine) {
            if (aMine == 'A') {
                return 2 * self.pointA;
            } else {
                return 2 * self.pointB;
            }
        }
        if (aMine == aShip && aMine != bShip && bShip == bMine) {
            return 0;
        }
        if (aShip != aMine && aMine == bShip && bShip == bMine) {
            if (aShip == 'A') {
                return self.pointA + 3 * self.pointB;
            } else {
                return self.pointB + 3 * self.pointA;
            }
        }
        if (aShip == bShip && aShip != aMine && aMine == bMine) {
            if (aShip == 'A') {
                return self.pointA;
            } else {
                return self.pointB;
            }
        }
        if (aMine != aShip && aShip == bShip && bShip == bMine) {
            return 0;
        }
        if (aShip == aMine && aShip == bMine && bMine != bShip) {
            return 0;
        }
        if (aShip == bMine && aShip != aMine && aMine == bShip) {
            if (bShip == 'A') {
                return 3 * self.pointA;
            } else {
                return 3 * self.pointB;
            }
        }
    },

    render: function() {
        if (this.state.gameFinished) {
            var pointsA = this.gamerPoints(this.state.gamerAShip, this.state.gamerAMine, this.state.gamerBShip, this.state.gamerBMine);
            var pointsB = this.gamerPoints(this.state.gamerBShip, this.state.gamerBMine, this.state.gamerAShip, this.state.gamerAMine);

            if (pointsA > pointsB) {
                var finishedBLock = <div>Поздравляем, Вы победили со
                    счетом {pointsA}:{pointsB}</div>;
            } else {
                if (pointsA == pointsB) {
                    var finishedBLock = <div>Ничья {pointsA}:{pointsB}</div>;
                } else {
                    var finishedBLock = <div>К сожалению Вы проиграли со
                        счетом {pointsA}:{pointsB}</div>;
                }
            }

            var fieldA = [];
            var fieldB = [];

            if (this.state.gamerAShip == 'A') {
                fieldA.push('Корабль игрока 1');
            } else {
                fieldB.push('Корабль игрока 1');
            }

            if (this.state.gamerBShip == 'A') {
                fieldA.push('Корабль игрока 2');
            } else {
                fieldB.push('Корабль игрока 2');
            }

            if (this.state.gamerAMine == 'A') {
                fieldA.push('Мина игрока 1');
            } else {
                fieldB.push('Мина игрока 1');
            }

            if (this.state.gamerBMine == 'A') {
                fieldA.push('Мина игрока 2');
            } else {
                fieldB.push('Мина игрока 2');
            }

            finishedBLock =
                <div>
                    <div>
                        <table border="1px">
                            <tr>
                                <td>Поле 1</td>
                                <td>Поле 2</td>
                            </tr>
                            <tr>
                                <td>{fieldA.join(', ')}</td>
                                <td>{fieldB.join(', ')}</td>
                            </tr>
                        </table>
                    </div>
                    <b>{finishedBLock}</b>
                </div>;
        }
        else {
            var finishedBLock = null;
        }

        if (this.state.showTip == 'yes') {
            var tipBlock =
                <div>
                    <h3>Стратегии</h3>
                    <table border="1px">
                        <tr><td>Стратегия</td><td>Описание</td></tr>
                        <tr><td>A1</td><td>Корабль - 1 клетка, Мина - 1 клетка</td></tr>
                        <tr><td>A2</td><td>Корабль - 1 клетка, Мина - 2 клетка</td></tr>
                        <tr><td>A3</td><td>Корабль - 2 клетка, Мина - 2 клетка</td></tr>
                        <tr><td>A4</td><td>Корабль - 2 клетка, Мина - 1 клетка</td></tr>
                        <tr><td>Стратегия</td><td>Описание</td></tr>
                        <tr><td>B1</td><td>Корабль - 1 клетка, Мина - 1 клетка</td></tr>
                        <tr><td>B2</td><td>Корабль - 1 клетка, Мина - 2 клетка</td></tr>
                        <tr><td>B3</td><td>Корабль - 2 клетка, Мина - 2 клетка</td></tr>
                        <tr><td>B4</td><td>Корабль - 2 клетка, Мина - 1 клетка</td></tr>
                    </table>
                    <h3>Матрица оптимальности</h3>
                    <table border="1px">
                        <tr>
                            <td></td>
                            <td>B1</td>
                            <td>B2</td>
                            <td>B3</td>
                            <td>B4</td>
                        </tr>
                        {this.combinations().map(function(row, index){
                            return (
                                <tr>
                                    <td>A{index + 1}</td>
                                    {row.map(function (pair, j) {
                                        return <td>{pair.join(', ')}, итог: <b>{pair[0]-pair[1]}</b></td>
                                    })}
                                </tr>
                            );
                        })}
                    </table>
                </div>
        }

        return(
            <div>
                <br/>
                <div>
                    <label>Очки точки А</label>
                    <input step="1" value={this.state.pointA} type="number" onChange={this.handleChangePointA}/>
                </div>
                <br/>
                <div>
                    <label>Очки точки Б</label>
                    <input step="1" value={this.state.pointB} type="number" onChange={this.handleChangePointB}/>
                </div>
                <br/>
                <button onClick={this.startNewGame}>Попробовать заново</button>
                <br/>
                <div>
                    <h3>Установите клетку для корабля</h3>
                    <div className="radio">
                        <label>
                            <input name="gamerAShip" type="radio" value="A" onChange={this.handleShipChange} checked={this.state.gamerAShip === 'A'} />
                            Установить корабль в точку A
                        </label>
                    </div>
                    <div className="radio">
                        <label>
                            <input name="gamerAShip" type="radio" value="B" onChange={this.handleShipChange} checked={this.state.gamerAShip === 'B'} />
                            Установить корабль в точку Б
                        </label>
                    </div>
                </div>

                <div>
                    <h3>Установите клетку для мины</h3>
                    <div className="radio">
                        <label>
                            <input name="gamerAMine" type="radio" value="A" onChange={this.handleMineChange} checked={this.state.gamerAMine === 'A'} />
                            Установить мину в точку A
                        </label>
                    </div>
                    <div className="radio">
                        <label>
                            <input name="gamerAMine" type="radio" value="B" onChange={this.handleMineChange} checked={this.state.gamerAMine === 'B'} />
                            Установить мину в точку Б
                        </label>
                    </div>
                </div>
                <br/>
                <div>
                    <h3>Показывать подсказки?</h3>
                    <div className="radio">
                        <label>
                            <input name="tips" type="radio" value="yes" onChange={this.handleTipChange} checked={this.state.showTip === 'yes'} />
                            Да
                        </label>
                    </div>
                    <div className="radio">
                        <label>
                            <input name="tips" type="radio" value="no" onChange={this.handleTipChange} checked={this.state.showTip === 'no'} />
                            Нет
                        </label>
                    </div>
                </div>
                <br/>
                <button onClick={this.runGame}>Играть</button>
                <br/>
                <br/>
                {finishedBLock}
                <br/>
                <br/>
                <br/>
                {tipBlock}
                <br/>
                <br/>
                <br/>
            </div>
        )
    }
});