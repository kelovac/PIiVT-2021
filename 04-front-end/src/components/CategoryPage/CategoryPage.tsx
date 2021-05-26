import { Link } from 'react-router-dom';
import BasePage, { BasePageProperties } from '../BasePage/BasePage';

class CategoryPageProperties extends BasePageProperties {
    match?: {
        params: {
            cid: string;
        }
    }
} 

class CategoryPageState {
    title: string = "";
    subcategories: number[] = [];
}

export default class CategoryPage extends BasePage<CategoryPageProperties> {
    state: CategoryPageState;

    constructor(props: CategoryPageProperties) {
        super(props);

        this.state = {
            title: "Loading...",
            subcategories: []
        };
    }

    private getCategoryId(): number|null {
        const cid = this.props.match?.params.cid;
        return cid ? +(cid) : null;
    }

    private getCategoryData() {
        const cid = this.getCategoryId();

        if (cid === null) {
            this.setState({
                title: "All categories.",
                subcategories: [
                    1, 4, 7, 13, 18
                ],
            });
        } else {
            this.setState({
                title: "Category " + cid,
                subcategories: [
                    cid,
                    cid + 10, 
                    cid + 11,
                    cid + 12,
                    cid + 13,
                    cid + 14,
                    cid + 15,
                ],
            });
        }
    }

    componentDidMount() {
        this.getCategoryData();
    }

    componentDidUpdate(prevProps: CategoryPageProperties, prevState: CategoryPageState) {
        if (prevProps.match?.params.cid !== this.props.match?.params.cid){
            this.getCategoryData();
        }
    }

    renderMain(): JSX.Element {
        return (
            <>
                <h1>{ this.state.title }</h1>
                <p>Potkategorije:</p>
                <ul>
                    { 
                        this.state.subcategories.map(
                            cat => (
                                <li key={"subcategory-link-" + cat }>
                                    <Link to={ "/category/" + cat }>
                                         Potkategorija { cat }
                                    </Link>
                                </li>
                            )
                        )
                    }
                    
                </ul>
            </>
        );
    }
}