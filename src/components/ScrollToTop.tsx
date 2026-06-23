import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/** Resets scroll when the route changes so new pages open at the top. */
export function ScrollToTop() {
  const { pathname } = useLocation();

  useEffect(() => {
    if ("scrollRestoration" in history) {
      history.scrollRestoration = "manual";
    }
    window.scrollTo(0, 0);
  }, [pathname]);

  return null;
}
