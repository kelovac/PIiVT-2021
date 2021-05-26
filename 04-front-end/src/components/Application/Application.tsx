import React from 'react';
import { Container } from 'react-bootstrap';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import CategoryPage from '../CategoryPage/CategoryPage';
import ContactPage from '../ContactPage/ContactPage';
import HomePage from '../HomePage/HomePage';
import TopMenu from '../TopMenu/TopMenu';
import './Application.sass';

export default function Application() {
  return (
    <BrowserRouter>
      <Container className="Application">
        <div className="Application-header">
          Front-end aplikacije
        </div>
        <TopMenu />

        <div className="Application-body">
          <Switch>
            <Route exact path="/" component={ HomePage } />

            <Route path="/category" component={ CategoryPage } />

            <Route path="/contact">
              <ContactPage 
                title="Our location in Belgrade"
                address="Danijelovac 32, 11010 Beograd, Srbija"
                phone="+381 11 30 94 094"/>
            </Route>
            
            <Route path="/profile">
              My profile
            </Route>
          </Switch>
        </div>

        <div>
          &copy; 2021...
        </div>
      </Container>
    </BrowserRouter>
  );
}

