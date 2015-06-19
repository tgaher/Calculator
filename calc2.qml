import QtQuick 2.0

Rectangle {
    id: root
    width: 200
    height: 250
    color: "grey"

    property string currentNumber: ""
    property int firstNumber
    property int secondNumber
    property string lastOperator


    Text
    {
        id: resDisplay
        height: 30
        width: 133
        y: 25
        x: 80
        text: ""
    }

    Rectangle
    {
        id: c
        width: 100
        height: 50
        x: 50
        y: 200
        color: "darkgray"
        Text
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "C"
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {   console.log("this")
                firstNumber = 0;
                secondNumber = 0;
                currentNumber= ""
                resDisplay.text= ""
            }
        }
    }

    Row
    {
        Grid
        {
            columns: 3
            anchors.bottom: parent.bottom

            Repeater
            {
                id: numberBtnRep

                Rectangle
                {
                    width: 50
                    height: 50
                    radius: 2

                    border.width: .5
                    border.color: "darkgray"
                    gradient: Gradient
                    {
                        GradientStop { position: 0.0; color: "#AAFFFFFF" }
                        GradientStop { position: 0.5; color: "darkgray" }
                        GradientStop { position: 1.0; color: "#AAFFFFFF" }
                    }

                    property string btnText: ""

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: parent.btnText
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            root.currentNumber += parent.btnText;
                            console.log(root.currentNumber);
                            resDisplay.text= root.currentNumber;
                        }
                    }
                }
            }
        }

        Column
        {
            Repeater
            {
                id: operatorBtnRep

                // TODO: Make a separate qml file for the button
                Rectangle
                {
                    width: 50
                    height: 50

                    border.width: 1
                    border.color: "darkgrey"
                    gradient: Gradient
                    {
                        GradientStop { position: 0.0; color: "#AAFF8C00" }
                        GradientStop { position: 0.5; color: "#e67e00" }
                        GradientStop { position: 1.0; color: "#AAFF8C00" }      //orange buttons
                    }

                    property string btnText: ""

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: parent.btnText
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {

                            if(parent.btnText === '=')   //some silly error bleh
                            {
                                secondNumber = parseInt(currentNumber);


                                if(lastOperator == '+')
                                {
                                    resDisplay.text= (firstNumber + secondNumber);
                                }
                                if(lastOperator == '-')
                                {
                                    resDisplay.text= (firstNumber - secondNumber);
                                }
                                if(lastOperator == 'x')
                                {
                                    resDisplay.text= (firstNumber * secondNumber);
                                }
                                if(lastOperator == '÷')
                                {
                                    resDisplay.text= (firstNumber/secondNumber);
                                    console.log(firstNumber + secondNumber);
                                }
                                secondNumber= parseInt(resDisplay.text);


                            }
                            else
                            {
                                lastOperator = parent.btnText;
                                resDisplay.text= resDisplay.text + lastOperator;
                                secondNumber = parseInt(currentNumber);
                                firstNumber= secondNumber;

                            }

                            firstNumber = parseInt(currentNumber);

                            currentNumber = '';


                        }
                    }
                }
            }
        }
    }


    function populateButtons()
    {
        var numBtns = ['7', '8', '9', '4', '5','6','1','2','3','0'];
        numberBtnRep.model = numBtns.length;

        for(var i = 0; i < numBtns.length; i++)
        {
            numberBtnRep.itemAt(i).btnText = numBtns[i];
        }

        var operatorBtns = ['÷', 'x', '-', '+', '='];
        operatorBtnRep.model = operatorBtns.length;

        for(i = 0; i < operatorBtns.length; i++)
        {
            operatorBtnRep.itemAt(i).btnText = operatorBtns[i];
        }

    }



    Component.onCompleted: populateButtons();
}

