<?php

/*
 * This file is part of the Sonata project.
 *
 * (c) Thomas Rabaix <thomas.rabaix@sonata-project.org>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Application\Sonata\PageBundle\Page\Service;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Sonata\SeoBundle\Seo\SeoPageInterface;

use Sonata\PageBundle\Page\Service\BasePageService;
use Sonata\PageBundle\Model\PageInterface;
use Sonata\PageBundle\Page\TemplateManagerInterface;

use Sonata\PageBundle\Page\Service\DefaultPageService as SonataDefaultPageService;

/**
 * Default page service to render a page template.
 *
 * Note: this service is backward-compatible and functions like the old page renderer class.
 *
 * @author Olivier Paradis <paradis.olivier@gmail.com>
 */
class DefaultPageService extends SonataDefaultPageService
{
    /**
     * @var TemplateManagerInterface
     */
    protected $templateManager;

    /**
     * @var SeoPageInterface
     */
    protected $seoPage;

    protected $seoPageTitle;

    /**
     * Constructor
     *
     * @param string                    $name            Page service name
     * @param TemplateManagerInterface  $templateManager Template manager
     * @param SeoPageInterface          $seoPage         SEO page object
     */
    public function __construct($name, TemplateManagerInterface $templateManager, SeoPageInterface $seoPage = null, $seoPageTitle = null)
    {
        parent::__construct($name, $templateManager, $seoPage);
        $this->setSeoPageTitle($seoPageTitle);
    }

    /**
     * @param mixed $seoPageTitle
     */
    public function setSeoPageTitle($seoPageTitle)
    {
        $this->seoPageTitle = $seoPageTitle;
    }

    /**
     * @return mixed
     */
    public function getSeoPageTitle()
    {
        return $this->seoPageTitle;
    }

    /**
     * Updates the SEO page values for given page instance
     *
     * @param PageInterface $page
     */
    protected function updateSeoPage(PageInterface $page)
    {
        if (!$this->seoPage) {
            return;
        }

        if (!$this->seoPage->getTitle() || $this->seoPage->getTitle() == $this->seoPageTitle) {
            $browserTitle = $page->getTitle() ?: $page->getName();
            $this->seoPage->addTitle($browserTitle);
        }

        if ($page->getMetaDescription()) {
            $this->seoPage->addMeta('name', 'description', $page->getMetaDescription());
        }

        if ($page->getMetaKeyword()) {
            $this->seoPage->addMeta('name', 'keywords', $page->getMetaKeyword());
        }

        $this->seoPage->addMeta('property', 'og:type', 'article');
        $this->seoPage->addHtmlAttributes('prefix', 'og: http://ogp.me/ns#');
    }
}
