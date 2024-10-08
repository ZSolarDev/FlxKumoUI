package kui.components;

import kui.util.TextStorage;
import kui.impl.Base;

class Text extends Component {

    private var text: TextStorage = new TextStorage();

    override function onRender(impl: Base) impl.drawText(text.getText(), getBoundsX(), getBoundsY(), text.getColor(), text.getSize(), text.getFont());

    override function onDataUpdate(data: Dynamic): Dynamic {
        text.text = data.text ?? '';
        text.size = data.size ?? Style.getInstance().TEXT_DEFAULT_SIZE;
        text.font = data.font ?? Style.getInstance().TEXT_DEFAULT_FONT;
        text.color = data.color ?? Style.getInstance().TEXT_DEFAULT_COLOR;
        return null;
    }

    override function onLayoutUpdate(impl: Base) {
        useLayoutPosition();
        setSize(text.getWidth(impl), text.getHeight(impl));
        useBoundsClipRect();
        submitLayoutRequest();
    }

}