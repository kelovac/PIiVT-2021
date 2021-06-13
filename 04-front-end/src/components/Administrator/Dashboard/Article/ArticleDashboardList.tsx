import BasePage from '../../../BasePage/BasePage';
import ArticleModel from '../../../../../../03-back-end/src/components/article/model';
import { Link } from 'react-router-dom';
import ArticleService from '../../../../services/ArticleService';
import { isRoleLoggedIn } from '../../../../api/api';
import EventRegister from '../../../../api/EventRegister';

interface ArticleDashboardListState {
    articles: ArticleModel[];
}

export default class ArticleDashboardList extends BasePage<{}> {
    state: ArticleDashboardListState;

    constructor(props: any) {
        super(props);

        this.state = {
            articles: [],
        }
    }

    componentDidMount() {
        isRoleLoggedIn("administrator")
        .then(loggedIn => {
            if (!loggedIn) return EventRegister.emit("AUTH_EVENT", "force_login");
            this.loadCategories();
        });
    }

    loadCategories() {
        ArticleService.getAllArticles("administrator")
        .then(articles => {
            this.setState({
                articles: articles,
            });
        });
    }

    renderMain(): JSX.Element {
        return (
            <>
                <h1>Articles</h1>
                <div>
                    <Link to="/dashboard/article/new" className="btn btn-sm btn-link">
                        Add new article
                    </Link>
                </div>
                <div>
                    { this.renderArticleGroup(this.state.articles) }
                </div>
            </>
        );
    }

    private renderArticleGroup(articles: ArticleModel[]): JSX.Element {
        if (!Array.isArray(articles)) {
            return (
                <></>
            );
        }

        return (
            <ul>
                {
                    articles.map(article => (
                        <li key={ "article-list-item-" + article.articleId }>
                            <b>{ article.title }</b>
                        </li>
                    ))
                }
            </ul>
        );
    }
}