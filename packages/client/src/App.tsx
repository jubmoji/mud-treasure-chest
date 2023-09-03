import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import { Scan } from "./Scan";

export const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/scan">
          <Scan />
        </Route>
        <Route path="/createGroup">
          {/* Insert CreateGroup component here */}
        </Route>
      </Routes>
    </Router>
  );
};
