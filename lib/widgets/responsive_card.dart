import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/responsive_utils.dart';

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool showShadow;
  final Gradient? gradient;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.showShadow = true,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveMargin = margin ?? ResponsiveUtils.getResponsiveCardMargin(context);
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    final responsiveElevation = elevation ?? (ResponsiveUtils.isMobile(context) ? 2.0 : 4.0);
    
    Widget cardContent = Container(
      padding: responsivePadding,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: showShadow ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: responsiveElevation * 2,
            offset: Offset(0, responsiveElevation),
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Container(
        margin: responsiveMargin,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: cardContent,
          ),
        ),
      );
    }

    return Container(
      margin: responsiveMargin,
      child: cardContent,
    );
  }
}

class ResponsiveGridCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool showShadow;
  final Gradient? gradient;

  const ResponsiveGridCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.showShadow = true,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? const EdgeInsets.all(16);
    final responsiveElevation = elevation ?? 2.0;
    
    Widget cardContent = Container(
      padding: responsivePadding,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: showShadow ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: responsiveElevation * 2,
            offset: Offset(0, responsiveElevation),
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}

class ResponsiveListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool showDivider;

  const ResponsiveListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: responsivePadding,
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null) title!,
                        if (subtitle != null) ...[
                          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 4)),
                          subtitle!,
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
        ],
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = fontSize != null 
        ? ResponsiveUtils.getResponsiveFontSize(context, fontSize!)
        : null;
    
    return Text(
      text,
      style: style?.copyWith(
        fontSize: responsiveFontSize,
        fontWeight: fontWeight,
        color: color,
      ) ?? TextStyle(
        fontSize: responsiveFontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
